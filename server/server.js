var firebase = require('firebase/app');
const firebasedb = require('firebase/database');
const { get, set, ref } = require("firebase/database");
const express = require('express');
const bodyParser = require('body-parser');

var app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
var server = app.listen(3000, console.log('Server is running on port 3000'));
const firebaseConfig = {
    databaseURL: "https://healthmate-7a6f2-default-rtdb.asia-southeast1.firebasedatabase.app/"
};

const connectdb = firebase.initializeApp(firebaseConfig);
export const db = firebasedb.getDatabase();

//create
app.post('/api/create', (req, res) => { // create user path /api/create
    var fullname = req.body.fullname;

    try {
        console.log("fullname>>>>>>>", fullname);
        // create path db here
        set(ref(db, 'users/' + fullname), {
            fullname: fullname,
            balance: 100,
            mil: new Date().getTime(),
            date: new Date().toLocaleString()
        });
        return res.status(200).json({
            RespCode: 200,
            RespMessage: "Success"
        });
    }
    catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message
        });
    }
});
//get all
app.get('/api/get', (req, res) => { // read user path /api/read
    try {
        get(ref(db, 'users'))
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
    catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message
        });
    }
});

//get by user
app.post('/api/getbyuser', (req, res) => {
    var fullname = req.body.fullname;
    try {
        get(ref(db, 'users/' + fullname))
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
    catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message
        });
    }
});

//update with request
app.put('/api/update', (req, res) => {
    var fullname = req.body.fullname;
    var balance = req.body.balance;
    try {
        set(ref(db, 'users/' + fullname), {
            fullname: fullname,
            balance: balance,
            mil: new Date().getTime(),
            date: new Date().toLocaleString()
        });
        return res.status(200).json({
            RespCode: 200,
            RespMessage: "Success"
        });
    }
    catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message
        });
    }
});

//delete
app.delete('/api/delete', (req, res) => {
    var fullname = req.body.fullname;
    try {
        set(ref(db, 'users/' + fullname), null);
        return res.status(200).json({
            RespCode: 200,
            RespMessage: "Success"
        });
    }
    catch (error) {
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message
        });
    }
});