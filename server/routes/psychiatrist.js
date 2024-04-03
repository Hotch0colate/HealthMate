const multer = require('multer');
const upload = multer({ dest: 'uploads/' });

const express = require('express');
const router = express.Router();
const firebasedb = require('firebase/database');
const db = require('../database/firebase.js');
const { get, set, ref, update, remove } = require("firebase/database");
var firebaseadmin = require("firebase-admin");
const cors = require('cors');
var app = express();
app.use(cors());
const formatDate = require('../service');
const authenticate = require('../token');


// สร้าง psychiatrist ด้วยอีเมล
// feature signup
router.post('/create_data', authenticate, upload.single('certificateimage'), async (req, res) => {
    var uid = req.user.uid;

    firstname = req.body.firstname;
    lastname = req.body.lastname;
    numbercertificate = req.body.numbercertificate;
    datecertificate = req.body.datecertificate;

    var pid = firebaseadmin.firestore().collection('psychiatrists').doc().id;


    try {
        firebasedb.set(ref(db, 'psychiatrists/' + pid), {
            pid: pid,
            uid: uid,
            firstname: firstname,
            lastname: lastname,
            numbercertificate: numbercertificate,
            datecertificate: datecertificate,
            mil: new Date().getTime(),
            date: formatDate(new Date())
        });
        return res.status(200).json({
            RespCode: 200,
            RespMessage: "Signup Successfully !"
        });
    }
    catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: "Error : " + error.message + "/nPath API : /psychiatrist/create_data"
        });

    }
});

//ดึงข้อมูลจาก psychiatrist
//fetch  psychiatrist
router.post('/read_data', (req, res) => {
    var uid = req.body.uid;

    try {
        firebasedb.get(ref(db, 'psychiatrists/' + uid))
            .then((snapshot) => {
                if (snapshot.exists()) {
                    // console.log(snapshot.val());
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessge: "Success",
                        Dae: snapshot.val()
                    });
                }
                else {
                    console.log("No data available from fetch data");
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "No data available" + "/nPath API : /psychiatrist/read_data"
                    });
                }
            })
    }
    catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message + "/nPath API : /psychiatrist/read_data"
        });
    }
});

// อัพเดทข้อมูล ถ้ามีการกรอกเฉพาะบางข้อมูลก็อัพเดทได้
// feature first login and edit profile
router.post('/update_data', (req, res) => {
    var pid = req.body.pid;


    var firstname = req.body.firstname;
    var lastname = req.body.lastname;
    var numbercertificate = req.body.numbercertificate;
    var datecertificate = formatDate(req.body.datecertificate);

    try {
        get(ref(db, 'psychiatrist/' + pid))
            .then((snapshot) => {
                if (snapshot.exists()) {
                    const updateData = {
                        mil: new Date().getTime(),
                        date: formatDate(new Date()),
                    };

                    // Optional Chaining
                    firstname && (updateData.firstname = firstname);
                    lastname && (updateData.lastname = lastname);
                    numbercertificate && (updateData.numbercertificate = numbercertificate);
                    datecertificate && (updateData.datecertificate = datecertificate);

                    update(ref(db, 'psychiatrist/' + uid), updateData);

                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "Update Successfully !" + "/nPath API : /psychiatrist/update_data"
                    });
                }
                else {
                    console.log("No data available");
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "No data available" + "/nPath API : /psychiatrist/update_data"
                    });
                }
            })
    }
    catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message + "/nPath API : /psychiatrist/update_data"
        });
    }
});

// ลบข้อมูล psychiatrist
// feature delete psychiatrist
router.post('/delete_data', (req, res) => {
    var pid = req.body.pid;

    try {
        get(ref(db, 'psychiatrist/' + pid))
            .then((snapshot) => {
                if (snapshot.exists()) {
                    remove(ref(db, 'psychiatrist/' + pid));

                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "Success" + "/nPath API : /psychiatrist/delete_data"
                    });
                }
                else {
                    console.log("No data available");
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "No data available" + "/nPath API : /psychiatrist/delete_data"
                    });
                }
            });
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message + "/nPath API : /psychiatrist/delete_data"
        });
    }
});

module.exports = router;

//clear