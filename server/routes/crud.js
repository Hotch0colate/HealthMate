const express = require('express');
const router = express.Router();
const firebasedb = require('firebase/database');
const db = require('../database/firebase.js');
const { get, set, ref } = require("firebase/database");
var firebaseadmin = require("firebase-admin");
const cors = require('cors');
var app = express();
app.use(cors());

//ใส่ชื่อฟังก์ชันด้วยทุกครั้ง
router.post('/api/create', (req, res) => {
    var fullname = req.body.fullname;

    try{
        firebasedb.set(ref(db, 'users/' + fullname), {
            fullname: fullname,
            balance: 100,
            mil: new Date().getTime(),
            date: new Date().toLocaleString()
        });
        return res.status(200).json({
            RespCode: 200,
            RespMessage: "Success"
        });
    }
    catch(error){
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message
        });
    }
});

//get all
router.get('/api/get', (req, res) => {
    try{
        firebasedb.get(ref(db, 'users'))
        .then((snapshot) => {
            if (snapshot.exists()) {
                console.log(snapshot.val());
                return res.status(200).json({
                    RespCode: 200,
                    RespMessage: "Success",
                    Data: snapshot.val()
                });
            } else {
                console.log("No data available");
                return res.status(200).json({
                    RespCode: 200,
                    RespMessage: "No data available"
                });
            }
        })
    }
    catch(error){
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message
        });
    }
});

//get by user
router.post('/api/getbyuser', (req, res) => {
    var fullname = req.body.fullname;
    try{
        firebasedb.get(ref(db, 'users/' + fullname))
        .then((snapshot) => {
            if (snapshot.exists()) {
                console.log(snapshot.val());
                return res.status(200).json({
                    RespCode: 200,
                    RespMessage: "Success",
                    Data: snapshot.val()
                });
            } else {
                console.log("No data available");
                return res.status(200).json({
                    RespCode: 200,
                    RespMessage: "No data available"
                });
            }
        })
    }
    catch(error){
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message
        });
    }
});

//update with request
router.put('/api/update', (req, res) => {
    var fullname = req.body.fullname;
    var balance = req.body.balance;
    try{
        firebasedb.set(ref(db, 'users/' + fullname), {
            fullname: fullname,
            balance: balance,
            mil: new Date().getTime(),
            date: new Date().toLocaleString()
        });
        return res.status(200).json({
            RespCode: 200,
            RespMessage: "Success"
        });
    }
    catch(error){
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message
        });
    }
});

//delete
router.delete('/api/delete', (req, res) => {
    var fullname = req.body.fullname;
    try{
        firebasedb.set(ref(db, 'users/' + fullname), null);
        return res.status(200).json({
            RespCode: 200,
            RespMessage: "Success"
        });
    }
    catch(error){
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message
        });
    }
});

//update with request
router.put('/api/updateHeight', (req, res) => {
    var fullname = req.body.fullname;
    var height = req.body.height;
    try{
        set(ref(db, 'users/' + fullname), {
            height: height
        });
        return res.status(200).json({
            RespCode: 200,
            RespMessage: "Success"
        });
    }
    catch(error){
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message
        });
    }
});

module.exports = router;

//clear