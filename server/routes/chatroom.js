const express = require('express');
const router = express.Router();
const firebasedb = require('firebase/database');
const db = require('../database/firebase.js');
const { get, set, ref, update, remove } = require("firebase/database");
var firebaseadmin = require("firebase-admin");
const cors = require('cors');
var app = express();
app.use(cors());

// สร้าง message และส่ง message ไปหาคู่สนทนา
// feature signup
router.post('/create_data', async (req, res) => { 
  var cid = req.body.cid;
  var mid = firebaseadmin.firestore().collection('chats').doc().id;

  var sender = req.body.sender;
  var text = req.body.text;
  try{
    firebasedb.get(ref(db, 'chats/' + cid))
    .then((snapshot) => {
        if (snapshot.exists()) {
          firebasedb.set(ref(db, 'chats/' + cid + '/messages/' + mid), {
            mid: mid,
            sender: sender,
            text: text,
            seen: false,
            mil: new Date().getTime(),
            date: new Date().toLocaleString()
          });
          return res.status(200).json({
            RespCode: 200,
            RespMessage: "Text Sent Successfully !"
          });
        } else {
            console.log("No data avilabel from fetch data");
            return res.status(200).json({
                RespCode: 200,
                RespMessage: "No data available" + "/nPath API : /chatroom/create_data"
            });
        }
    })
}
catch(error){
    console.log(error);
    return res.status(500).json({
        RespCode:500,
        RespMessage: error.message + "/nPath API : /chatroom/create_data"
    });
}
});

// ดึงข้อความจาก message
// fetch message
router.post('/read_data', (req, res) => {
  var cid = req.body.cid;

  try {
      firebasedb.get(ref(db, 'chats/' + cid + '/messages'))
          .then((snapshot) => {
              if (snapshot.exists()) {
                  const messages = snapshot.val();  // ดึงข้อมูลทั้งหมดใน messages
                  const messagesArray = Object.values(messages);  // แปลง object เป็น array

                  console.log(messagesArray);
                  return res.status(200).json({
                      RespCode: 200,
                      RespMessge: "Success",
                      Data: messagesArray  // ส่ง array ของ messages กลับ
                  });
              } else {
                  console.log("No data available from fetch data");
                  return res.status(200).json({
                      RespCode: 200,
                      RespMessage: "No data available" + "/nPath API : /chatroom/read_data"
                  });
              }
          })
  } catch (error) {
      console.log(error);
      return res.status(500).json({
          RespCode: 500,
          RespMessage: error.message + "/nPath API : /chatroom/read_data"
      });
  }
});


// ลบข้อมูล message
// feature delete message
router.post('/delete_data', (req, res) => {
  var cid = req.body.cid;
  var mid = req.body.mid

  try {
      get(ref(db, 'chats/' + cid + '/messages/' + mid))
          .then((snapshot) => {
              if (snapshot.exists()) {
                  remove(ref(db, 'chats/' + cid + '/messages/' + mid));

                  return res.status(200).json({
                      RespCode: 200,
                      RespMessage: "Success" + "/nPath API : /chatroom/delete_data"
                  });
              } else {
                  console.log("No data available");
                  return res.status(200).json({
                      RespCode: 200,
                      RespMessage: "No data available" + "/nPath API : /chatroom/delete_data"
                  });
              }
          });
  } catch (error) {
      console.log(error);
      return res.status(500).json({
          RespCode: 500,
          RespMessage: error.message + "/nPath API : /chatroom/delete_data"
      });
  }
});


module.exports = router;