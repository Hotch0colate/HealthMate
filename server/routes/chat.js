const express = require('express');
const router = express.Router();
const firebasedb = require('firebase/database');
const db = require('../database/firebase.js');
const { get, set, ref } = require("firebase/database");
var firebaseadmin = require("firebase-admin");
const cors = require('cors');
var app = express();
app.use(cors());

//send chat
router.post('/send', async (req, res) => { 
    const chat = {
        sender: req.body.sender,
        receiver: req.body.receiver,
        message: req.body.message
    }
    firebasedb.set(ref(db, 'chats/' + chat.sender + '/' + chat.receiver), {
        sender: chat.sender,
        receiver: chat.receiver,
        message: chat.message,
        mil: new Date().getTime(),
        date: new Date().toLocaleString()
    });
    firebasedb.set(ref(db, 'chats/' + chat.receiver + '/' + chat.sender), {
        sender: chat.sender,
        receiver: chat.receiver,
        message: chat.message,
        mil: new Date().getTime(),
        date: new Date().toLocaleString()
    });
    return res.status(200).json({
        RespCode: 200,
        RespMessage: "Success"
    });
});

module.exports = router;