const express = require('express');
const router = express.Router();
const firebasedb = require('firebase/database');
const db = require('../database/firebase.js');
const { get, set, ref } = require("firebase/database");
var firebaseadmin = require("firebase-admin");
const cors = require('cors');
var app = express();
const authenticate = require('../token');
app.use(cors());
const { formatDate, anonymouseNames } = require('../service');

//create chatlog
//feature create chatlog
router.post('/create_data', authenticate, async (req, res) => {
    var user = req.user.uid;
    var volunteer = req.body.volunteer;
    var cid = firebaseadmin.firestore().collection('chats').doc().id;
    var psychiatristchat = req.body.psychiatristchat;

    const randomIndexForUser = Math.floor(Math.random() * anonymouseNames.length);
    const randomIndexForVolunteer = Math.floor(Math.random() * anonymouseNames.length);

    var volunteerAnon;

    var userAnon = anonymouseNames[randomIndexForUser];
    if (!psychiatristchat) {
        volunteerAnon = anonymouseNames[randomIndexForVolunteer];
    }
    else {
        try {
            const _snapshot = await firebasedb.get(ref(db, 'psychiatrists/' + volunteer + '/firstname'));
            if (_snapshot.exists()) {
                volunteerAnon = _snapshot.val();
            } else {
                console.log("No psychiatrist data available");
                volunteerAnon = anonymouseNames[randomIndexForVolunteer];
            }
        } catch (error) {
            console.log("Failed to fetch psychiatrist data:", error);
            volunteerAnon = anonymouseNames[randomIndexForVolunteer];
        }
    }

    try {
        set(ref(db, 'chats/' + cid), {
            cid: cid,
            user: user,
            volunteer: volunteer,
            messages: {},
            lastsender: "",
            lastmessage: "",
            seen: false,
            complete: false,
            psychiatristchat: psychiatristchat,
            anonymoususername: userAnon,
            anonymousvolunteername: volunteerAnon,
            mil: new Date().getTime(),
            date: formatDate(new Date())
        });
        const userRef = ref(db, 'users/' + user);
        const volunteerRef = ref(db, 'users/' + volunteer);
        firebasedb.get(userRef).then((snapshot) => {
            if (snapshot.exists()) {
                var newchatgroup = snapshot.val().chatgroup || [];
                newchatgroup.push(cid);
                firebasedb.update(userRef, { chatgroup: newchatgroup })
                    .then(() => {
                        console.log("Update user chatgroup successfully!");
                    })
                    .catch((error) => {
                        console.log("Error update user chatgroup: ", error);
                    });
            }
        });
        firebasedb.get(volunteerRef).then((snapshot) => {
            if (snapshot.exists()) {
                var newchatgroup = snapshot.val().chatgroup || [];
                newchatgroup.push(cid);
                firebasedb.update(volunteerRef, { chatgroup: newchatgroup })
                    .then(() => {
                        console.log("Update volunteer chatgroup successfully!");
                    })
                    .catch((error) => {
                        console.log("Error update volunteer chatgroup: ", error);
                    });
            }
        });
        return res.status(200).json({
            RespCode: 200,
            RespMessage: "Create Chatlog Successfully !",
            Data: cid,
            userUid: user,
            volunteerUid: volunteer,
            anonymoususername: userAnon,
            anonymousvolunteername: volunteerAnon
        });
    }
    catch (error) {
        console.log(error)
        return res.status(500).json({
            RespCode: 500,
            RespMessage: "Error : " + error.message + "/nPath API : /chatlog/create_data"
        });
    }
});

//fetch all chatlog
router.post('/read_data', (req, res) => {
    var uid = req.body.uid;

    try {
        firebasedb.get(ref(db, 'users/' + uid + '/chatgroup'))
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
                        RespMessage: "No data available",
                        Data: []
                    });
                }
            })
    }
    catch (error) {
        return res.status(500).json({
            RespCode: 500,
            RespMessage: "Error : " + error.message + "/nPath API : /chatlog/read_data"
        });
    }
});

router.post('/read_data_all', async (req, res) => {
    const uid = req.body.uid;

    try {
        const userChatGroupRef = ref(db, `users/${uid}/chatgroup`);
        const userChatGroupSnapshot = await get(userChatGroupRef);

        if (userChatGroupSnapshot.exists()) {
            const userChatGroups = userChatGroupSnapshot.val();
            // console.log(userChatGroups);

            const chatData = [];

            for (const chatgroupId in userChatGroups) {
                const chatRef = ref(db, `chats/${userChatGroups[chatgroupId]}`);
                const chatSnapshot = await get(chatRef);

                if (chatSnapshot.exists()) {
                    const chatInfo = chatSnapshot.val();
                    const messages = Object.values(chatInfo.messages || {});
                    const formattedChat = {
                        cid: userChatGroups[chatgroupId],
                        complete: chatInfo.complete || false,
                        date: chatInfo.date || "",
                        lastmessage: chatInfo.lastmessage || "",
                        messages: messages.map(message => ({
                            ...message,
                            date: message.date || "",
                            mid: message.mid || "",
                            mil: message.mil || 0,
                            seen: message.seen || false,
                            sender: message.sender || "",
                            text: message.text || ""
                        })),
                        mil: chatInfo.mil || 0,
                        seen: chatInfo.seen || false,
                        user: chatInfo.user || "",
                        volunteer: chatInfo.volunteer || ""
                    };
                    chatData.push(formattedChat);
                } else {
                    chatData = [];
                }
            }

            return res.status(200).json({
                RespCode: 200,
                RespMessage: "Success",
                Data: chatData
            });
        }
        else {
            console.log("No user chat group available");
            return res.status(200).json({
                RespCode: 200,
                RespMessage: "No user chat group available",
                Data: []
            });
        }
    } catch (error) {
        console.error("Error:", error.message);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: "Error: " + error.message + "/nPath API : /chatlog/read_data_all"
        });
    }
});


// อัพเดทข้อมูล
// Seen in chatlog update
router.post('/update_data', (req, res) => {
    var cid = req.body.cid;

    try {
        get(ref(db, 'psychiatrist/' + uid))
            .then((snapshot) => {
                if (snapshot.exists()) {
                    const updateData = {
                        seen: true
                    };

                    update(ref(db, 'chats/' + cid), updateData);

                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "Update Successfully !" + "/nPath API : /chatlog/update_data"
                    });
                }
                else {
                    console.log("No data available");
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "No data available" + "/nPath API : /chatlog/update_data"
                    });
                }
            })
    }
    catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: "Error : " + error.message + "/nPath API : /chatlog/update_data"
        });
    }
});

module.exports = router;

//clear