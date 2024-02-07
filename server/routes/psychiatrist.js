const express = require('express');
const router = express.Router();
const firebasedb = require('firebase/database');
const db = require('../database/firebase.js');
const { get, set, ref, update, remove } = require("firebase/database");
var firebaseadmin = require("firebase-admin");
const cors = require('cors');
var app = express();
app.use(cors());


// สร้าง psychiatrist ด้วยอีเมล
// feature signup
router.post('/crete_data', async (req, res) => {
  const user = {
      username: req.body.username,
      email: req.body.email,
      password: req.body.password
  }
  firebaseadmin.auth().createUser(user)
  .then((userCredential) => {
      var uid = userCredential.uid;
      firebasedb.set(ref(db, 'psychiatrists/' + uid), {
          uid: uid,
          username:user.username,
          email: user.email,
          password: user.password,
          age: 0,
          birthday: "unknow",
          gender: "unknow",
          carrer: "unknow",
          martial_status: "unknow",
          chatgroup: [],
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
          RespMessage: "Error : " + error.message + "/nPath API : /psychiatrist/create_data"
      });
  });
});

//ดึงข้อมูลจาก psychiatrist
//fetch  psychiatrist
router.post('/read_data', (req, res) => {
  var uid = req.body.uid;
  try{
      firebasedb.get(ref(db, 'psychiatrists/' + uid))
      .then((snapshot) => {
          if (snapshot.exists()) {
              console.log(snapshot.val());
              return res.status(200).json({
                  RespCode: 200,
                  RespMessge: "Success",
                  Dae: snapshot.val()
              });
          } else {
              console.log("No data avilabel from fetch data");
              return res.status(200).json({
                  RespCode: 200,
                  RespMessage: "No data available" + "/nPath API : /psychiatrist/read_data"
              });
          }
      })
  }
  catch(error){
      console.log(error);
      return res.status(500).json({
          RespCode:500,
          RespMessage: error.message + "/nPath API : /psychiatrist/read_data"
      });
  }
});

// อัพเดทข้อมูล ถ้ามีการกรอกเฉพาะบางข้อมูลก็อัพเดทได้
// feature first login and edit profile
router.post('/update_data', (req, res) => {
    var uid = req.body.uid;

    var username = req.body.username;
    var password = req.body.password;
    var age = req.body.age;
    var gender = req.body.gender;
    var birthday = req.body.birthday;
    var career = req.body.career;
    var martial_status = req.body.martial_status;

    try {
        get(ref(db, 'psychiatrist/' + uid))
            .then((snapshot) => {
                if (snapshot.exists()) {
                    const updateData = {
                        mil: new Date().getTime(),
                        date: new Date().toLocaleString(),
                    };

                    // Optional Chaining
                    username &&(updateData.username = username);
                    password &&(updateData.password = password);
                    age && (updateData.age = age);
                    gender && (updateData.gender = gender);
                    birthday && (updateData.birthday = birthday);
                    career && (updateData.career = career);
                    martial_status && (updateData.martial_status = martial_status);

                    update(ref(db, 'psychiatrist/' + uid), updateData);

                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "Update Successfully !" + "/nPath API : /psychiatrist/update_data"
                    });
                } else {
                    console.log("No data available");
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "No data available" + "/nPath API : /psychiatrist/update_data"
                    });
                }
            })
    }
    catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message + "/nPath API : /psychiatrist/update_data"
        });
    }
});

// ลบข้อมูล psychiatrist
// feature delete psychiatrist
router.post('/delete_data', (req, res) => {
    var uid = req.body.uid;

    try {
        get(ref(db, 'psychiatrist/' + uid))
            .then((snapshot) => {
                if (snapshot.exists()) {
                    remove(ref(db, 'psychiatrist/' + uid));

                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "Success" + "/nPath API : /psychiatrist/delete_data"
                    });
                } else {
                    console.log("No data available");
                    return res.status(200).json({
                        RespCode: 200,
                        RespMessage: "No data available" + "/nPath API : /psychiatrist/delete_data"
                    });
                }
            });
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message + "/nPath API : /psychiatrist/delete_data"
        });
    }
});

module.exports = router;