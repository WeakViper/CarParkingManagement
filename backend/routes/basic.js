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

router.post('/gettowers', (req, res) => {
    let query = 'SELECT TowerID FROM Tower WHERE BranchID = ?'
    db.query(query, [req.body.branchid], (err, rows) => {
        if (err) {
            console.log(err.message);
            return;
        }
        res.send(rows);
    });
});

router.post('/getbranches', (req, res) => {
    let query = 'SELECT BranchID FROM BranchClient'
    db.query(query, (err, rows) => {
        if (err) {
            console.log(err.message);
            return;
        }
        res.send(rows);
    });
});


module.exports = router;