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
const { formatDate } = require('../service');


//สร้าง volunteer
//feature volunteer register
router.post('/create_data', authenticate, async (req, res) => {
    var uid = req.user.uid;

    var tags = req.body.tags;

    try {
        firebasedb.set(ref(db, 'volunteers/' + uid), {
            uid: uid,
            help_quota: 3,
            weekly_quota: 5,
            tags: [],
            rating_score: 100,
            mil: new Date().getTime(),
            date: formatDate(new Date())
        });

        const updateData = {
            mil: new Date().getTime(),
            date: formatDate(new Date())
        };
        // Optional Chaining
        tags && (updateData.tags = tags);
        update(ref(db, 'volunteers/' + uid), updateData);

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
router.post('/read_data', authenticate, (req, res) => {
    var uid = req.user.uid;

    try {
        firebasedb.get(ref(db, 'volunteers/' + uid))
            .then((snapshot) => {
                if (snapshot.exists()) {
                    // console.log(snapshot.val());
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
router.post('/update_data', authenticate, (req, res) => {
    var uid = req.user.uid;

    var tags = req.body.tags;
    var rating_score = req.body.rating_score;
    var weekly_quota = req.body.weekly_quota;
    var help_quota = req.body.help_quota;

    try {
        get(ref(db, 'volunteers/' + uid))
            .then((snapshot) => {
                if (snapshot.exists()) {
                    const updateData = {
                        mil: new Date().getTime(),
                        date: formatDate(new Date())
                    };
                    // Optional Chaining
                    tags && (updateData.tags = tags);
                    rating_score && (updateData.rating_score = rating_score);
                    weekly_quota && (updateData.weekly_quota = weekly_quota);
                    help_quota && (updateData.help_quota = help_quota);
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
router.post('/delete_data', authenticate, (req, res) => {
    var uid = req.user.uid;

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

router.post('/query_data', authenticate, async (req, res) => {
    var uid = req.user.uid;
    var tag = req.body.tags;

    try {
        const snapshot = await get(ref(db, 'volunteers'));
        if (snapshot.exists()) {
            let volunteers = snapshot.val();
            // console.log(tag);

            // Convert object to array and include uid in each item
            volunteers = Object.entries(volunteers).map(([uid, details]) => ({
                uid,
                ...details,
                tagMatch: details.tags && details.tags.includes(tag),
                hasGeneric: details.tags && details.tags.includes("generic")
            }));

            // Filter out volunteers without matching or generic tag
            let matchingVolunteers = volunteers.filter(v => v.uid !== uid && (v.tagMatch || v.hasGeneric));

            // Sort by tag match, then by quotas and score
            matchingVolunteers.sort((a, b) => {
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
            if (matchingVolunteers.length === 0 || matchingVolunteers[0].weekly_quota === 0 || matchingVolunteers[0].help_quota === 0) {
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
                weekly_quota: matchingVolunteers[0].weekly_quota - 1,
                help_quota: matchingVolunteers[0].help_quota - 1
            };
            update(ref(db, 'volunteers/' + matchingVolunteers[0].uid), updateData);


            return res.status(200).json({
                RespCode: 200,
                RespMessage: "Query successful",
                Data: matchingVolunteers[0].uid
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
            RespMessage: `Error: ${error.message}\nPath API: /query_data`
        });
    }
});

router.post('/check_data', authenticate, (req, res) => {
    var uid = req.user.uid;

    try {
        firebasedb.get(ref(db, 'volunteers'))
            .then((snapshot) => {
                if (snapshot.exists()) {
                    const psychiatrists = snapshot.val();
                    let found = false;
                    for (let _uid in psychiatrists) {
                        if (psychiatrists[_uid].uid === uid) {
                            found = true;
                            return res.status(200).json({
                                RespCode: 200,
                                RespMessage: "Success",
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