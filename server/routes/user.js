const express = require('express');
const router = express.Router();
const firebasedb = require('firebase/database');
const db = require('../database/firebase.js');
const { get, set, ref, update, remove } = require("firebase/database");
var firebaseadmin = require("firebase-admin");
const cors = require('cors');
var app = express();
const authenticate = require('../token');
app.use(cors());




// สร้าง user ด้วยอีเมล
// feature signup
router.post('/create_data', async (req, res) => {
    uid = req.body.uid
    username = req.body.username
    email = req.body.email
    password = req.body.password

    try {
        firebasedb.set(ref(db, 'users/' + uid), {
            uid: uid,
            username: username,
            email: email,
            password: password,
            age: 0,
            birthday: "unknow",
            gender: "unknow",
            carrer: "unknow",
            martial_status: "unknow",
            chatgroup: [],
            mil: new Date().getTime(),
            date: new Date().toLocaleString()
        });
        return res.status(200).json({
            RespCode: 200,
            RespMessage: "Signup successfully !"
        });
    }
    catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: "Error : " + error.message + "/nPath API : /user/create_data"
        });
    }
});


//ดึงข้อมูลจาก user
//fetch  userdata
router.post('/read_data', authenticate, async (req, res) => {
    var uid = req.body.uid;

    try {
        firebasedb.get(ref(db, 'users/' + uid))
            .then((snapshot) => {
                if (snapshot.exists()) {
                    console.log(snapshot.val());
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessge: "Fetch data success",
                        Dae: snapshot.val()
                    });
                }
                else {
                    console.log("No data avilabel");
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
            RespMessage: "Error : " + error.message + "/nPath API : /user/read_data"
        });
    }
});

// อัพเดทข้อมูล ถ้ามีการกรอกเฉพาะบางข้อมูลก็อัพเดทได้
// feature first login and edit profile
router.post('/update_data', (req, res) => {
    var uid = req.body.uid;

    var username = req.body.username;
    var password = req.body.password;
    var age = req.body.age;
    var gender = req.body.gender;
    var birthday = req.body.birthday;
    var career = req.body.career;
    var martial_status = req.body.martial_status;
    //check attribute in database
    try {
        get(ref(db, 'users/' + uid))
            .then((snapshot) => {
                if (snapshot.exists()) {
                    const updateData = {
                        mil: new Date().getTime(),
                        date: new Date().toLocaleString(),
                    };

                    // Optional Chaining
                    username && (updateData.username = username);
                    password && (updateData.password = password);
                    age && (updateData.age = age);
                    gender && (updateData.gender = gender);
                    birthday && (updateData.birthday = birthday);
                    career && (updateData.career = career);
                    martial_status && (updateData.martial_status = martial_status);

                    update(ref(db, 'users/' + uid), updateData);

                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "Update successfully !"
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
            RespMessage: "Error : " + error.message + "/nPath API : /user/update_data"
        });
    }
});

// ลบข้อมูล user
// feature delete user
router.post('/delete_data', (req, res) => {
    var username = req.body.username;

    try {
        get(ref(db, 'users/' + username))
            .then((snapshot) => {
                if (snapshot.exists()) {
                    remove(ref(db, 'users/' + username));
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "Success"
                    });
                }
                else {
                    console.log("No data available");
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "No data available"
                    });
                }
            });
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: "Error : " + error.message + "/nPath API : /user/delete_data"
        });
    }
});

module.exports = router;

//clear