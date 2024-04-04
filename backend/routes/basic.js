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
        res.status(500).send(err.message);
        return;
    }
    console.log("Database connected.");
});

router.post('/gettowers', (req, res) => {
    let query = 'SELECT TowerID FROM Tower WHERE BranchID = ?'
    db.query(query, [req.body.branchid], (err, rows) => {
        if (err) {
            res.status(500).send(err.message);
            return;
        }
        res.send(rows);
    });
});

router.post('/getbranches', (req, res) => {
    let query = 'SELECT BranchID FROM BranchClient'
    db.query(query, (err, rows) => {
        if (err) {
            res.status(500).send(err.message);
            return;
        }
        res.send(rows);
    });
});


router.post('/getslot', (req, res) => {
    let query = 'SELECT ParkingSlotID, ParkingZoneID FROM Occupy WHERE plateNumber = ?'
    db.query(query, [req.body.plateNumber], (err, response) => {
        if (err) {
            res.json({
                message: "None"
            });
            return;
        }
        if (response.length == 0) {
            res.json({
                message: "None"
            });
        } else {
            res.json({
                message: "Success",
                slotID: response[0].ParkingSlotID,
                zoneID: response[0].ParkingZoneID
            });
        }
    });
});


router.post('/deletebranch', (req, res) => {
    let query = 'DELETE FROM BranchClient WHERE BranchID = ?'
    db.query(query, [req.body.branchID], (err, res) => {
        if (err) {
            res.status(500).send(err.message);
            return;
        }
        if (res.body.length == 0) {
            res.json({
                message: "None"
            });
        } else {
            res.json({
                message: "Success",
                slotID: res[0].ParkingSlotID,
                zoneID: res[0].ParkingZoneID
            });
        }
    });
});


router.post('/updatestaff', (req, res) => {
    let query = 'SELECT * FROM Staff WHERE EmployeeID = ?'
    db.query(query, [req.body.employeeID], (err, res) => {
        if (err) {
            res.error(err.message);
            return;
        }
        let query2 = `UPDATE Staff 
        SET FullName = ?, email = ?, Telephone = ?, BranchID = ?, Shift = ?, StartDate = ? 
        WHERE EmployeeID = ?;`
        const values = [req.body.fullName, req.body.email, req.body.telephone, req.body.branchID, req.body.shift, req.body.startDate, req.body.employeeID]
        db.query(query2, values, (err, res) => {
            if (err) {
                res.status(500).send(err.message);
                return;
            }
        });
    });
});

router.post('/countentries', (req, res) => {
    let query = `SELECT PlateNumber, COUNT(*) AS entries FROM Enters
    GROUP BY PlateNumber;`
    db.query(query, (err, response) => {
        if (err) {
            res.status(500).send(err.message);
            return;
        }
        res.send(response);
    });
});


router.post('/busiestgate', (req, res) => {
    let query = `SELECT ExitGateID 
    FROM Exits
    GROUP BY ExitGateID 
    HAVING COUNT(*) >= (
        SELECT COUNT(*)
        FROM Exits e
        GROUP BY e.ExitGateID
    );`
    db.query(query, (err, response) => {
        if (err) {
            res.status(500).send(err.message);
            return;
        }
        res.send(response);
    });
});

router.post('/methodamt', (req, res) => {
    let query = `SELECT Method, SUM(Amount)
    FROM Payment p
    GROUP BY Method
    HAVING SUM(Amount) > ?;`
    db.query(query, [req.body.amount], (err, response) => {
        if (err) {
            res.status(500).send(err.message);
            return;
        }
        res.send(response);
    });
});

router.post('/gatewithamt', (req, res) => {
    let query = `SELECT e.ExitGateID , SUM(p.Amount)
    FROM Exits e , Payment p 
    WHERE e.PlateNumber = p.PlateNumber
    GROUP BY e.ExitGateID 
    HAVING SUM(p.Amount) > ?;`
    db.query(query, [req.body.amount], (err, response) => {
        if (err) {
            res.status(500).send(err.message);
            return;
        }
        res.send(response);
    });
});



module.exports = router;