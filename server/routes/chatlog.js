const express = require('express');
const router = express.Router();
const firebasedb = require('firebase/database');
const db = require('../database/firebase.js');
const { get, set, ref } = require("firebase/database");
var firebaseadmin = require("firebase-admin");
const cors = require('cors');
var app = express();
app.use(cors());

//create chatlog
//feature create chatlog
router.post('/create_data', async (req, res) => {
    var user = req.body.user;
    var volunteer = req.body.volunteer;
    var cid = firebaseadmin.firestore().collection('chats').doc().id;
    /////////////////
    console.log("cid", cid);
    console.log(typeof(cid));
    try{
        set(ref(db, 'chats/' + cid), {
            cid: cid,
            user: user,
            volunteer: volunteer,
            messages: {},
            complete: false,
            mil: new Date().getTime(),
            date: new Date().toLocaleString()
        });
        const userRef = ref(db, 'users/' + user);
        const volunteerRef = ref(db, 'users/' + volunteer);
        firebasedb.get(userRef).then((snapshot) => {
            if (snapshot.exists()) {
                var newchatgroup = snapshot.val().chatgroup || [];
                newchatgroup.push(cid);
                firebasedb.update(userRef, {chatgroup:newchatgroup})
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
                firebasedb.update(volunteerRef, {chatgroup:newchatgroup})
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
            RespMessage: "Create Chatlog Successfully !"
        });
    }
    catch(error){
        console.log(error)
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message
        });
    }
});

//fetch all chatlog
router.post('/read_data', (req, res) => {
    var uid = req.body.uid;
    const userRef = ref(db, 'users');
    const query = query(userRef, orderByChild('chatgroup'), equalTo(chatGroupToQuery));
    try{
        firebasedb.get(query)
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
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message
        });
    }
});

module.exports = router;