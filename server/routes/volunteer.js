const express = require('express');
const router = express.Router();
const firebasedb = require('firebase/database');
const db = require('../database/firebase.js');
const { get, set, ref, update, remove } = require("firebase/database");
var firebaseadmin = require("firebase-admin");
const cors = require('cors');
var app = express();
app.use(cors());


//สร้าง volunteer
//feature volunteer register
router.post('/create_data', async (req, res) => {
    var uid = req.body.uid;

    try {
        firebasedb.set(ref(db, 'volunteers/' + uid), {
            uid: uid,
            help_quota: 3,
            weekly_help: 5,
            tags: [],
            rating_score: 100,
            mil: new Date().getTime(),
            date: new Date().toLocaleString()
        });
        return res.status(200).json({
            RespCode: 200,
            RespMessage: "Register volunteer succesfully !"
        });
    }
    catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: "Error : " + error.message + "/nPath API : /volunteer/create_data"
        });
    }
});

//ดึงข้อมูลจาก volunteer
//fetch volunteer data
router.post('/read_data', (req, res) => {
    var uid = req.body.uid;

    try {
        firebasedb.get(ref(db, 'volunteers/' + uid))
            .then((snapshot) => {
                if (snapshot.exists()) {
                    console.log(snapshot.val());
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "Success",
                        Data: snapshot.val()
                    });
                }
                else {
                    console.log("No data available");
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "No data available"
                    });
                }
            })
    }
    catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: "Error : " + error.message + "/nPath API : /volunteer/read_data"
        });
    }
});

//update volunteer data
router.post('/update_data', (req, res) => {
    var uid = req.body.uid;

    var tags = req.body.tags;
    var rating_score = req.body.rating_score;

    try {
        get(ref(db, 'volunteers/' + uid))
            .then((snapshot) => {
                if (snapshot.exists()) {
                    const updateData = {
                        mil: new Date().getTime(),
                        date: new Date().toLocaleString(),
                    };
                    // Optional Chaining
                    tags && (updateData.tags = tags);
                    rating_score && (updateData.rating_score = rating_score);
                    update(ref(db, 'volunteers/' + uid), updateData);
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "Update Successfully !"
                    });
                }
                else {
                    console.log("No data available");
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "No data available"
                    });
                }
            })
    }
    catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: "Error : " + error.message + "/nPath API : /volunteer/update_data"
        });
    }
});

//ลบข้อมูล volunteer
//feature delete volunteer
router.post('/delete_data', (req, res) => {
    var uid = req.body.uid;

    try {
        get(ref(db, 'volunteers/' + uid))
            .then((snapshot) => {
                if (snapshot.exists()) {
                    remove(ref(db, 'volunteers/' + uid));
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "Delete Successfully !"
                    });
                }
                else {
                    console.log("No data available");
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "No data available"
                    });
                }
            })
    }
    catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: "Error : " + error.message + "/nPath API : /volunteer/delete_data"
        });
    }
});

module.exports = router;

//clear