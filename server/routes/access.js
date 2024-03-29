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


//sign in
router.post('/signin', authenticate, async (req, res) => {
    return res.status(200).json({ message: 'User authenticated successfully', user: req.user });
});

router.get('/get_uid', authenticate, async (req, res) => {
    // console.log("UID:" + req.user.uid);
    return res.status(200).json({ uid: req.user.uid });
})

module.exports = router;

//clear