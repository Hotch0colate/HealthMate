const express = require('express');
const router = express.Router();
const firebasedb = require('firebase/database');
const db = require('../database/firebase.js');
const { get, set, ref } = require("firebase/database");
var firebaseadmin = require("firebase-admin");
const cors = require('cors');
var app = express();
app.use(cors());



//signup
router.post('/signup', async (req, res) => { 
    const user = {
        email: req.body.email,
        password: req.body.password
    }
    firebaseadmin.auth().createUser(user)
    .then((userCredential) => {
        // Signed in 
        var uid = userCredential.uid;
        firebasedb.set(ref(db, 'users/' + uid), {
            uid: uid,
            email: user.email,
            password: user.password,
            mil: new Date().getTime(),
            date: new Date().toLocaleString()
        });
        return res.status(200).json({
            RespCode: 200,
            RespMessage: "Signup Successfully !"
        });
    })
    .catch((error) => {
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message
        });
    });
});

module.exports = router;