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

// สร้าง emotion ด้วยอีเมล
// feature signup
router.post('/create_data', authenticate, async (req, res) => {
  uid = req.user.uid
  emotion = req.body.emotion
  description = req.body.description

  const options = { day: '2-digit', month: '2-digit', year: 'numeric' }
  const dateDisplay = new Date().toLocaleDateString('th-TH', options).replace(/\//g, '-').replace(/[\.\#\$\[\]]/, ''); // ลบอักขระไม่อนุญาต
  var eid = firebaseadmin.firestore().collection('users').doc(uid).collection('calendar').doc(dateDisplay).collection('emotions').doc().id;


  try {
    firebasedb.set(ref(db, 'users/' + uid + '/calendar/' + dateDisplay + '/emotions/' + eid), {
      eid: eid,
      emotion: emotion,
      description: description,
      time: new Date().toLocaleString()
    });
    const updateData = {
      lastemotion: emotion,
    };
    update(ref(db, 'users/' + uid + '/calendar/' + dateDisplay), updateData);
    return res.status(200).json({
      RespCode: 200,
      RespMessage: "Emotion create successfully !"
    });
  }
  catch (error) {
    console.log(error);
    return res.status(500).json({
      RespCode: 500,
      RespMessage: "Error : " + error.message + "/nPath API : /emotion/create_data"
    });
  }
});


//ดึงข้อมูลจาก emotions
//fetch  emotions
router.post('/read_all_data', authenticate, async (req, res) => {
  var uid = req.user.uid;

  try {
    firebasedb.get(ref(db, 'users/' + uid + '/calendar'))
      .then((snapshot) => {
        if (snapshot.exists()) {
          let allData = snapshot.val();
          let emotionsData = {};

          // Loop through each date key and extract the lastemotion
          Object.keys(allData).forEach(date => {
            if (allData[date] && allData[date].lastemotion) {
              emotionsData[date] = allData[date].lastemotion;
            }
          });

          // console.log(emotionsData);

          return res.status(200).json({
            RespCode: 200,
            RespMessage: "Fetch data success",
            Data: emotionsData // ส่งข้อมูลที่กรองแล้วกลับไป
          });
        }
        else {
          console.log("No data avilabel");
          return res.status(200).json({
            RespCode: 200,
            RespMessage: "No data available",
            Data: {}
          });
        }
      })
  }
  catch (error) {
    console.log(error);
    return res.status(500).json({
      RespCode: 500,
      RespMessage: "Error : " + error.message + "/nPath API : /emotion/read_data"
    });
  }
});


//ดึงข้อมูลจาก emotions ตามวันที่
//fetch  emotions
router.post('/read_data', authenticate, async (req, res) => {
  var uid = req.user.uid;

  var dayMonthYear = req.body.dayMonthYear; // รับค่า MM-yyyy จาก request body
  var dayMonthYearParts = dayMonthYear.split('-');
  var targetDay = parseInt(dayMonthYearParts[0], 10);
  var targetMonth = parseInt(dayMonthYearParts[1], 10);
  if (targetDay < 10) {
    targetDay = "0" + targetDay;
  }
  if (targetMonth < 10) {
    targetMonth = "0" + targetMonth;
  }
  var targetYear = parseInt(dayMonthYearParts[2], 10);

  try {
    console.log('users/' + uid + '/calendar/' + targetDay + '-' + targetMonth + '-' + targetYear + '/emotions');
    firebasedb.get(ref(db, 'users/' + uid + '/calendar/' + targetDay + '-' + targetMonth + '-' + targetYear + '/emotions'))
      .then((snapshot) => {
        if (snapshot.exists()) {
          return res.status(200).json({
            RespCode: 200,
            RespMessage: "Fetch data success",
            Data: snapshot.val() // ส่งข้อมูลที่กรองแล้วกลับไป
          });
        }
        else {
          console.log("No data avilabel");
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
      RespMessage: "Error : " + error.message + "/nPath API : /emotion/read_data"
    });
  }
});

// ลบข้อมูล emotion
// feature delete emotion
// router.post('/delete_data', authenticate, (req, res) => {
//   var uid = req.user.uid;
//   var date = req.body.date;
//   var eid = req.body.eid;

//   console.log('users/' + uid + '/calendar/' + date + '/emotions/' + eid);

//   try {
//     get(ref(db, 'users/' + uid + '/calendar/' + date + '/emotions/' + eid))
//       .then((snapshot) => {
//         if (snapshot.exists()) {
//           remove(ref(db, 'users/' + uid + '/calendar/' + date + '/emotions/' + eid));
//           return res.status(200).json({
//             RespCode: 200,
//             RespMessage: "Deleted successfully"
//           });
//         }
//         else {
//           console.log("No data available");
//           return res.status(200).json({
//             RespCode: 200,
//             RespMessage: "No data available"
//           });
//         }
//       });
//   } catch (error) {
//     console.log(error);
//     return res.status(500).json({
//       RespCode: 500,
//       RespMessage: "Error : " + error.message + "/nPath API : /emotion/delete_data"
//     });
//   }
// });

router.post('/delete_data', authenticate, (req, res) => {
  var uid = req.user.uid;
  var date = req.body.date;
  var eid = req.body.eid;

  const datePath = 'users/' + uid + '/calendar/' + date;
  const emotionsPath = datePath + '/emotions/';
  const emotionToDeletePath = emotionsPath + eid;
  const lastEmotionPath = datePath + '/lastemotion';

  console.log(emotionToDeletePath);

  try {
    get(ref(db, emotionsPath)).then((snapshot) => {
      if (snapshot.exists() && snapshot.hasChild(eid)) {
        // Delete the specified emotion
        remove(ref(db, emotionToDeletePath));

        // Check if there are any emotions left after deletion
        const remainingEmotions = snapshot.val();
        const testEmotions = Object.keys(remainingEmotions)
          .map(key => ({ ...remainingEmotions[key], key }))
        delete remainingEmotions[eid]; // Remove the deleted emotion from local copy

        if (Object.keys(remainingEmotions).length === 0) {
          // If no emotions are left, delete the whole date
          remove(ref(db, datePath));
        } else {
          // Find and set the last emotion
          const sortedEmotions = Object.keys(remainingEmotions)
            .map(key => ({ ...remainingEmotions[key], key }))
            .sort((a, b) => new Date(b.time) - new Date(a.time));
          set(ref(db, lastEmotionPath), sortedEmotions[sortedEmotions.length - 1].emotion);
        }

        return res.status(200).json({
          RespCode: 200,
          RespMessage: "Deleted successfully"
        });
      } else {
        console.log("No data available");
        return res.status(200).json({
          RespCode: 200,
          RespMessage: "No data available"
        });
      }
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      RespCode: 500,
      RespMessage: "Error : " + error.message + "/nPath API : /emotion/delete_data"
    });
  }
});


module.exports = router;

//clear