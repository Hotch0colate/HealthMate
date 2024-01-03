import { initializeApp } from 'firebase/app';
import { getDatabase, set, ref,get } from 'firebase/database';
import express  from 'express';
import bodyParser  from 'body-parser';

var app2 = express();
app2.use(bodyParser.json());
app2.use(bodyParser.urlencoded({ extended: true }));
var server = app2.listen(3000, console.log('Server is running on port 3000'));

const firebaseConfig = {
    databaseURL: "https://healthmate-7a6f2-default-rtdb.asia-southeast1.firebasedatabase.app/"
};

const app = initializeApp(firebaseConfig);
const db = getDatabase();

//create
app2.post('/api/create', (req, res) => { // create user path /api/create
    var fullname = req.body.fullname;

    try{
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
    catch(error){
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message
        });
    }
});

app2.get('/api/get', (req, res) => { // read user path /api/read
    try{
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
    catch(error){
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message
        });
    }
});

//get by user
app2.post('/api/getbyuser', (req, res) => {
    var fullname = req.body.fullname;
    try{
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
    catch(error){
        console.log(error);
        return res.status(500).json({
            RespCode: 500,
            RespMessage: error.message
        });
    }
});