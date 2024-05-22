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
const { formatDate } = require('../service');
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

    try {
        firebasedb.set(ref(db, 'psychiatrists/' + uid), {
            uid: uid,
            firstname: firstname,
            lastname: lastname,
            numbercertificate: numbercertificate,
            datecertificate: datecertificate,
            help_quota: 3,
            weekly_quota: 5,
            rating_score: 100,
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


    var firstname = req.body.firstname;
    var lastname = req.body.lastname;
    var numbercertificate = req.body.numbercertificate;
    if (req.body.datecertificate) {
        var datecertificate = formatDate(req.body.datecertificate);
    }

    var tags = req.body.tags;
    var rating_score = req.body.rating_score;
    var weekly_quota = req.body.weekly_quota;
    var help_quota = req.body.help_quota;

    try {
        get(ref(db, 'psychiatrists/' + uid))
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
                    tags && (updateData.tags = tags);
                    rating_score && (updateData.rating_score = rating_score);
                    weekly_quota && (updateData.weekly_quota = weekly_quota);
                    help_quota && (updateData.help_quota = help_quota);

                    update(ref(db, 'psychiatrists/' + uid), updateData);

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
router.post('/delete_data', authenticate, (req, res) => {
    var uid = req.user.uid


    try {
        get(ref(db, 'psychiatrists/' + uid))
            .then((snapshot) => {
                if (snapshot.exists()) {
                    remove(ref(db, 'psychiatrists/' + uid));

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

router.post('/query_data', authenticate, async (req, res) => {
    var uid = req.user.uid;
    var tag = req.body.tags;

    try {
        const snapshot = await get(ref(db, 'psychiatrists'));
        if (snapshot.exists()) {
            let psychiatrists = snapshot.val();

            console.log(tag);

            // Convert object to array and include uid in each item
            psychiatrists = Object.entries(psychiatrists).map(([uid, details]) => ({
                uid,
                ...details,
                tagMatch: details.tags && details.tags.includes(tag),
                hasGeneric: details.tags && details.tags.includes("generic")
            }));

            console.log(psychiatrists);
            // Filter out volunteers without matching or generic tag
            let matchingPsychiatrists = psychiatrists.filter(v => v.uid !== uid && (v.tagMatch || v.hasGeneric));

            // Sort by tag match, then by quotas and score
            matchingPsychiatrists.sort((a, b) => {
                // Prioritize tag match over "Generic"
                if (a.tagMatch && !b.tagMatch) {
                    if (a.weekly_quota === 0 || a.help_quota === 0) return 1;
                    return -1;
                }
                if (!a.tagMatch && b.tagMatch) {
                    if (b.weekly_quota === 0 || b.help_quota === 0) return -1;
                    return 1;
                }
                if (a.hasGeneric !== b.hasGeneric && a.tagMatch !== b.tagMatch) return b.hasGeneric - a.hasGeneric;

                // Then sort by weekly_quota, help_quota, rating_score
                if (a.weekly_quota !== b.weekly_quota) return b.weekly_quota - a.weekly_quota;
                if (a.help_quota !== b.help_quota) return b.help_quota - a.help_quota;
                return b.rating_score - a.rating_score;
            });

            // Check if a match is found
            if (matchingPsychiatrists.length === 0 || matchingPsychiatrists[0].weekly_quota === 0 || matchingPsychiatrists[0].help_quota === 0) {
                console.log('data == null');
                // console.log(matchingPsychiatrists.length);
                return res.status(200).json({
                    RespCode: 200,
                    RespMessage: "No match found",
                    Data: null
                });
            }

            // Return the uid of the best match
            const updateData = {
                mil: new Date().getTime(),
                date: formatDate(new Date()),
                weekly_quota: matchingPsychiatrists[0].weekly_quota - 1,
                help_quota: matchingPsychiatrists[0].help_quota - 1
            };
            update(ref(db, 'psychiatrists/' + matchingPsychiatrists[0].uid), updateData);
            console.log('query successful');
            return res.status(200).json({
                RespCode: 200,
                RespMessage: "Query successful",
                Data: matchingPsychiatrists[0].uid
            });
        } else {
            console.log('404 not found');
            return res.status(404).json({
                RespCode: 404,
                RespMessage: "No psychiatrists found"
            });
        }
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: `Error: ${error.message}\nPath API: /query_data`
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
                                uid: uid
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