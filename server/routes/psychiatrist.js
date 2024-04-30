const multer = require('multer');
const upload = multer({ dest: 'uploads/' });

const express = require('express');
const bodyParser = require('body-parser');

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

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// สร้าง psychiatrist ด้วยอีเมล
// feature signup
router.post('/create_data', authenticate, upload.single('certificateimage'), async (req, res) => {
    var uid = req.user.uid;

    firstname = req.body.firstname;
    lastname = req.body.lastname;
    numbercertificate = req.body.numbercertificate;
    datecertificate = req.body.datecertificate;

    const tags = JSON.parse(req.body.tags);

    var pid = firebaseadmin.firestore().collection('psychiatrists').doc().id;

    try {
        firebasedb.set(ref(db, 'psychiatrists/' + pid), {
            pid: pid,
            uid: uid,
            firstname: firstname,
            lastname: lastname,
            numbercertificate: numbercertificate,
            datecertificate: datecertificate,
            tags: tags,
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
            RespMessage: "Error : " + error.message + "/nPath API : /psychiatrists/create_data"
        });

    }
});

//ดึงข้อมูลจาก psychiatrist
//fetch  psychiatrist
router.post('/read_data', authenticate, (req, res) => {
    var uid = req.user.uid;

    var pid = req.body.pid;

    try {
        firebasedb.get(ref(db, 'psychiatrists/' + pid))
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
                        RespMessage: "No data available" + "/nPath API : /psychiatrists/read_data"
                    });
                }
            })
    }
    catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message + "/nPath API : /psychiatrists/read_data"
        });
    }
});

// อัพเดทข้อมูล ถ้ามีการกรอกเฉพาะบางข้อมูลก็อัพเดทได้
// feature first login and edit profile
router.post('/update_data', (req, res) => {
    console.log(req.body);
    var pid = req.body.pid;


    var firstname = req.body.firstname;
    var lastname = req.body.lastname;
    var numbercertificate = req.body.numbercertificate;
    if (req.body.datecertificate) {
        var datecertificate = formatDate(req.body.datecertificate);
    }


    var tags = req.body.tags;
    var rating_score = req.body.rating_score;

    try {
        get(ref(db, 'psychiatrists/' + pid))
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
                    tags && (updateData.tags = tags);
                    rating_score && (updateData.rating_score = rating_score);

                    update(ref(db, 'psychiatrists/' + pid), updateData);

                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "Update Successfully !" + "/nPath API : /psychiatrists/update_data"
                    });
                }
                else {
                    console.log("No data available");
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "No data available" + "/nPath API : /psychiatrists/update_data"
                    });
                }
            })
    }
    catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message + "/nPath API : /psychiatrists/update_data"
        });
    }
});

// ลบข้อมูล psychiatrist
// feature delete psychiatrist
router.post('/delete_data', (req, res) => {
    var pid = req.body.pid;

    try {
        get(ref(db, 'psychiatrists/' + pid))
            .then((snapshot) => {
                if (snapshot.exists()) {
                    remove(ref(db, 'psychiatrists/' + pid));

                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "Success" + "/nPath API : /psychiatrists/delete_data"
                    });
                }
                else {
                    console.log("No data available");
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "No data available" + "/nPath API : /psychiatrists/delete_data"
                    });
                }
            });
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message + "/nPath API : /psychiatrists/delete_data"
        });
    }
});

router.post('/check_data', authenticate, (req, res) => {
    var uid = req.user.uid;

    try {
        firebasedb.get(ref(db, 'psychiatrists'))
            .then((snapshot) => {
                if (snapshot.exists()) {
                    const psychiatrists = snapshot.val();
                    let found = false;
                    for (let pid in psychiatrists) {
                        if (psychiatrists[pid].uid === uid) {
                            found = true;
                            return res.status(200).json({
                                RespCode: 200,
                                RespMessage: "Success",
                                pid: pid
                            });
                        }
                    }
                    if (!found) {
                        return res.status(404).json({
                            RespCode: 404,
                            RespMessage: "No psychiatrist found with the provided uid"
                        });
                    }
                }
                else {
                    console.log("No data available from fetch data");
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "No data available" + "/nPath API : /check_psychiatrist"
                    });
                }
            })
            .catch((error) => {
                console.log(error);
                return res.status(500).json({
                    RespCode: 500,
                    RespMessage: error.message + "/nPath API : /check_psychiatrist"
                });
            });
    }
    catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: "Error while fetching psychiatrist: " + error.message
        });
    }
});


module.exports = router;

//clear