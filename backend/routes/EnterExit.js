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

    // this is to insert the vehicle into the VehicleClass table
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

    console.log("C");

    res.send("Vehicle entered successfully!");
})



module.exports = router;