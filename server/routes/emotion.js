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
router.post('/create_data', async (req, res) => {
  uid = req.body.uid
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
router.post('/read_all_data', async (req, res) => {
  var uid = req.body.uid;

  var monthYear = req.body.monthsYear; // รับค่า MM-yyyy จาก request body
  var monthYearParts = monthYear.split('-');
  var targetMonth = parseInt(monthYearParts[0], 10);
  var targetYear = parseInt(monthYearParts[1], 10);

  try {
    firebasedb.get(ref(db, 'users/' + uid + '/calendar'))
      .then((snapshot) => {
        if (snapshot.exists()) {
          let allData = snapshot.val();
          let filteredData = {};
          // กรองข้อมูลโดยวนลูปผ่าน keys ของ allData
          Object.keys(allData).forEach(date => {
            let dateParts = date.split('-'); // สมมติว่า date มีรูปแบบ dd-MM-yyyy
            // let day = parseInt(dateParts[0], 10);
            let month = parseInt(dateParts[1], 10);
            let year = parseInt(dateParts[2], 10);

            // เช็คว่าเดือนและปีตรงกับ targetMonth และ targetYear หรือไม่
            if (month === targetMonth && year === targetYear) {
              filteredData[date] = allData[date]; // เก็บข้อมูลที่ตรงกัน
            }
          });

          return res.status(200).json({
            RespCode: 200,
            RespMessage: "Fetch data success",
            Data: filteredData // ส่งข้อมูลที่กรองแล้วกลับไป
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


//ดึงข้อมูลจาก emotions ตามวันที่
//fetch  emotions
router.post('/read_data', async (req, res) => {
  var uid = req.body.uid;

  var dayMonthYear = req.body.dayMonthYear; // รับค่า MM-yyyy จาก request body
  var dayMonthYearParts = dayMonthYear.split('-');
  var targetDay = parseInt(dayMonthYearParts[0], 10);
  var targetMonth = parseInt(dayMonthYearParts[1], 10);
  if (targetMonth < 10) {
    targetMonth = "0" + targetMonth;
  }
  var targetYear = parseInt(dayMonthYearParts[2], 10);

  try {
    console.log('users/' + uid + '/calendar/' + targetDay + '-' + targetMonth + '-' + targetYear);
    firebasedb.get(ref(db, 'users/' + uid + '/calendar/' + targetDay + '-' + targetMonth + '-' + targetYear))
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
router.post('/delete_data', (req, res) => {
  var uid = req.body.uid;
  var date = req.body.date;
  var eid = req.body.eid;

  try {
    get(ref(db, 'users/' + uid + '/calendar/' + date + '/emotions/' + eid))
      .then((snapshot) => {
        if (snapshot.exists()) {
          remove(ref(db, 'users/' + uid + '/calendar/' + date + '/emotions/' + eid));
          return res.status(200).json({
            RespCode: 200,
            RespMessage: "Deleted successfully"
          });
        }
        else {
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