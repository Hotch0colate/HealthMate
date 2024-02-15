var firebaseapp = require('firebase/app');
const firebasedb = require('firebase/database');
const { get, set, ref } = require("firebase/database");
var firebaseadmin = require("firebase-admin");
var serviceAccount = require("./serviceAccountKey.json");

const firebaseConfig = {
    credential: firebaseadmin.credential.cert(serviceAccount),
    databaseURL: "https://health-9cd54-default-rtdb.asia-southeast1.firebasedatabase.app/"
};
const admindb = firebaseadmin.initializeApp(firebaseConfig);
const connectdb = firebaseapp.initializeApp(firebaseConfig);
const db = firebasedb.getDatabase();

module.exports = firebaseapp;
module.exports = firebaseadmin;
module.exports = firebasedb
module.exports = {get, set, ref};
module.exports = db;