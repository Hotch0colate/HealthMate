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

router.post('/query_volunteers', async (req, res) => {
    const { tag } = req.body;

    try {
        const snapshot = await get(ref(db, 'volunteers'));
        if (snapshot.exists()) {
            let volunteers = snapshot.val();

            // Convert object to array and include uid in each item
            volunteers = Object.entries(volunteers).map(([uid, details]) => ({
                uid,
                ...details,
                tagMatch: details.tags.includes(tag) || tag === "ALL"
            }));

            // Filter by tag or "ALL"
            let matchingVolunteers = volunteers.filter(v => v.tagMatch);

            matchingVolunteers.sort((a, b) => {
                // ตรวจสอบและเปลี่ยน tags ที่ไม่ตรงเป็น "ALL"
                if (!tagsMatch(a.tags)) a.tags = "ALL";
                if (!tagsMatch(b.tags)) b.tags = "ALL";

                // การเรียงลำดับตาม tags, weekly_quota, help_quota, และ rating_score
                if (a.tags !== b.tags) return a.tags.localeCompare(b.tags);
                if (a.weekly_quota !== b.weekly_quota) return b.weekly_quota - a.weekly_quota;
                if (a.help_quota !== b.help_quota) return b.help_quota - a.help_quota;
                return b.rating_score - a.rating_score;
            });

            // ตรวจสอบหลังจากเรียงลำดับแล้วว่ามีคู่จับได้หรือไม่
            if (matchingVolunteers.length === 0 || (matchingVolunteers[0].weekly_quota === 0 && matchingVolunteers[0].help_quota === 0)) {
                return res.status(200).json({
                    RespCode: 200,
                    RespMessage: "No match found",
                    Data: null
                });
            }


            return res.status(200).json({
                RespCode: 200,
                RespMessage: "Query successful",
                Data: matchingVolunteers[0].uid // Return an array of uids
            });
        } else {
            return res.status(404).json({
                RespCode: 404,
                RespMessage: "No volunteers found"
            });
        }
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: `Error: ${error.message}\nPath API: /query_volunteers`
        });
    }
});


module.exports = router;

//clear