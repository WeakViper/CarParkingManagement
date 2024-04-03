const mysql = require("mysql");
const express = require('express'); 

const router = express.Router();

const db = mysql.createConnection({
    host: "database-1.cfygwy4i0v9o.us-east-2.rds.amazonaws.com",
    port: "3306",
    user: "admin",
    password: "password",
    database: "cpms_db",
})

db.connect((err) => {
    if (err) {
        console.log(err.message);
        return;
    }
    console.log("Database connected.");
});

router.post('/enter', async (req, res) => {
    const { plateNumber, weightClass, extra, entryGate, TowerID } = req.body;
    const sql1 = 'INSERT INTO VehicleClass (plateNumber, weightClass) VALUES (?, ?)';
    const values1 = [plateNumber, weightClass];

    function checkPlateNumber (plateNumber) {
        const query = 'SELECT * FROM Occupy WHERE PlateNumber = ?';
    
        db.query(query, [plateNumber], (err, results) => {
            if (err) {
                console.error('Error executing query:', err);
                return;
            }
    
            if (results.length = 0) {
                console.log(`Plate number ${plateNumber} exists in the Occupy table.`);
                db.query(sql1, values1, (err, result, fields) => {
                    if (err) {
                        return res.send(err.message);
                    }
                    return console.log(result);
                })
                let sql2;
                let values2;
                if (weightClass === "A") {
                    sql2 = 'INSERT INTO PrivateCar VALUES (?, ?)';
                    values2 = [plateNumber, extra];
                } else if (weightClass === "B") {
                    sql2 = 'INSERT INTO HeavyDuty VALUES (?, ?)';
                    values2 = [plateNumber, extra];
                } else if (weightClass === "C") {
                    sql2 = 'INSERT INTO Maintenance VALUES (?, ?)';
                    values2 = [plateNumber, extra];
                } else {
                    sql2 = 'INSERT INTO PrivateCar VALUES (?, ?)';
                    values2 = [plateNumber, extra]; //remeber to get right extra val from frontend
                    console.log("Invalid weight class");
                }
            
                // this is to insert the vehicle into the correct table
                db.query(sql2, values2, (err, result, fields) => {
                    if (err) {
                        console.log(err.message);
                        return;
                    }
                    return console.log(result);
                })
            } else {
                console.log(`Plate number ${plateNumber} does not exist in the Occupy table.`);
                let sql2;
                const values2 = [extra, plateNumber];
                if (weightClass === "A") {
                    sql2 = 'UPDATE PrivateCar SET Extra = ? WHERE PlateNumber = ?';
                } else if (weightClass === "B") {
                    sql2 = 'UPDATE HeavyDuty SET Extra = ? WHERE PlateNumber = ?';
                } else if (weightClass === "C") {
                    sql2 = 'UPDATE Maintenance SET Extra = ? WHERE PlateNumber = ?';
                } else {
                    sql2 = 'UPDATE PrivateCar SET Extra = ? WHERE PlateNumber = ?';
                    console.log("Invalid weight class");
                }
            
                // this is to insert the vehicle into the correct table
                db.query(sql2, values2, (err, result, fields) => {
                    if (err) {
                        console.log(err.message);
                        return;
                    }
                    return console.log(result);
                })
            }
        });
    }
    
    // Example usage
    checkPlateNumber(plateNumber);
    
    let sql3 = 'INSERT INTO Enters VALUES (NOW(), ?, ?)';
    let values3 = [entryGate, plateNumber];   

    // this is to insert the vehicle into entry table
    db.query(sql3, values3, (err, result, fields) => {
        if (err) {
            console.log(err.message);
            console.log("r2");
            return;

        }
        return console.log(result);

    })

    let zone;
    if (weightClass === "A") {
        zone = 1;
    } else if (weightClass === "B") {
        zone = 2;
    } else if (weightClass === "C") {
        zone = 3;
    } else {
        zone = 4;
        console.log("Invalid Zone class");
    }



    const ZoneQuery = `SELECT p.ParkingZoneID
    FROM ParkingZone p
    WHERE p.TowerID = '100'
    INTERSECT (
        SELECT pz.ParkingZoneID
        FROM ParkingZone pz
        WHERE pz.ParkingZoneType = 1 AND pz.ZoneTotalSlots > (
            SELECT COUNT(o.ParkingSlotID)
            FROM Occupy o
            WHERE o.ParkingZoneID = pz.ParkingZoneID
        )
        UNION
        SELECT pz.ParkingZoneID
        FROM ParkingZone pz
        WHERE pz.ParkingZoneType = 4 AND pz.ZoneTotalSlots > (
            SELECT COUNT(o.ParkingSlotID)
            FROM Occupy o
            WHERE o.ParkingZoneID = pz.ParkingZoneID
        )
    )
    LIMIT 1;`;

    const getZoneId = async (zoneID) => {
        return new Promise((resolve, reject) => {
            db.query(ZoneQuery, [zone, TowerID], (err, result, fields) => {
                if (err) {
                    reject(err.message);
                } else {
                    resolve(result[0].ParkingZoneID);
                }
            })
        });
    }

    // Usage
    const zoneID = await getZoneId();



    const slotQuery = `SELECT ps.ParkingSlotID 
    FROM ParkingSlot ps
    WHERE ps.ParkingZoneID = ? AND ps.ParkingSlotID NOT IN 
    (
        SELECT o.ParkingSlotID
        FROM Occupy o
        WHERE o.ParkingZoneID = ?
    )
    LIMIT 1;
    `;

    const getSlotId = async (zoneID) => {
        return new Promise((resolve, reject) => {
            db.query(slotQuery, [zoneID, zoneID], (err, result, fields) => {
                if (err) {
                    reject(err.message);
                } else {
                    resolve(result[0].ParkingSlotID);
                }
            })
        });
    }

    // Usage
    const parkingSlotID = await getSlotId(zoneID);


    const sql4 = 'INSERT INTO Occupy VALUES (?, ?, ?)';
    const values4 = [parkingSlotID, zoneID, plateNumber];   

    // this is to insert the vehicle into entry table
    db.query(sql4, values4, (err, result, fields) => {
        if (err) {
            return res.send(err.message);
        }
        return console.log(result);
    })

    res.send("Vehicle entered successfully!");
})



router.post('/exit', async (req, res) => {
    const { plateNumber, exitGate, method } = req.body;

    const getSlot = async (plateNumber) => {
        return new Promise((resolve, reject) => {
            db.query("SELECT ParkingSlotID FROM Occupy WHERE PlateNumber = ? LIMIT 1", [plateNumber], (err, result, fields) => {
                if (err) {
                    reject(err.message);
                } else {
                    console.log(result);
                    resolve(result[0].ParkingSlotID);
                }
            })
        });
    }

    // Usage
    const slotID = await getSlot(plateNumber);

    const getZone = async (plateNumber) => {
        return new Promise((resolve, reject) => {
            db.query("SELECT ParkingZoneID FROM Occupy WHERE PlateNumber = ? LIMIT 1", [plateNumber], (err, result, fields) => {
                if (err) {
                    reject(err.message);
                } else {
                    resolve(result[0].ParkingZoneID);
                }
            })
        });
    }

    // Usage
    const zoneID = await getZone(plateNumber);

    const enterIntoExits = async (plateNumber) => {
        return new Promise((resolve, reject) => {
            db.query("INSERT INTO Exits VALUES (NOW(),?, ?, ?, ?)", [exitGate, plateNumber, zoneID, slotID], (err, result, fields) => {
                if (err) {
                    reject(err.message);
                } else {
                    resolve();
                }
            })
        });
    }

    // Usage
    await enterIntoExits(plateNumber);

    const sql2 = 'DELETE FROM Occupy WHERE plateNumber = ?';
    const values2 = [plateNumber];

    // this is to delete the vehicle from the Occupy table
    db.query(sql2, values2, (err, result, fields) => {
        if (err) {
            return res.send(err.message);
        }
        return console.log(result);
    })

    const getClass = async (plateNumber) => {
        return new Promise((resolve, reject) => {
            db.query("SELECT WeightClass FROM VehicleClass WHERE PlateNumber = ?", [plateNumber], (err, result, fields) => {
                if (err) {
                    reject(err.message);
                } else {
                    resolve(result[0].WeightClass);
                }
            })
        });
    }

    // Usage
    const weightClass = await getClass(plateNumber);

    const getRate = async (weightClass) => {
        return new Promise((resolve, reject) => {
            db.query("SELECT HourlyRate FROM WeightRate WHERE WeightClass = ?", [weightClass], (err, result, fields) => {
                if (err) {
                    reject(err.message);
                } else {
                    resolve(result[0].HourlyRate);
                }
            })
        });
    }

    
    // Usage
    const weightRate = await getRate(weightClass);

    const entryTimeQuery = `SELECT 
    TIMESTAMPDIFF(
        SECOND, 
        (SELECT e.DateTime FROM Enters e WHERE e.PlateNumber = ? ORDER BY e.DateTime DESC LIMIT 1),
        (SELECT e.DateTime FROM Exits e WHERE e.PlateNumber = ? ORDER BY e.DateTime DESC LIMIT 1)
    ) / 3600.0 AS DifferenceInHours`

    const getTimeDifference = async (plateNumber) => {
        return new Promise((resolve, reject) => {
            db.query(entryTimeQuery, [plateNumber, plateNumber], (err, result, fields) => {
                if (err) {
                    reject(err.message);
                } else {
                    resolve(result[0].DifferenceInHours);
                }
            })
        });
    }

    const timeDifference = await getTimeDifference(plateNumber);

    let amount = timeDifference * weightRate;

    const randomId = Math.floor(Math.random() * 1000); // Generates a random number between 0 and 999
    const paymentId = `PID${randomId}`;

    // Add the generated payment ID to the beginning of the values array
    const values3 = [paymentId, method, plateNumber, exitGate, amount];

    const sql3 = 'INSERT INTO Payment VALUES (?, ?, ?, ?, ?)';

    db.query(sql3, values3, (err, result, fields) => {
        if (err) {
            console.log(err.message);
        } else {
            console.log(result);
        }
    })

    res.send("Exit successful!");


})

module.exports = router;