var firebaseapp = require('firebase/app');
const firebasedb = require('firebase/database');
const { get, set, ref } = require("firebase/database");
var firebaseadmin = require("firebase-admin");
var serviceAccount = require("./serviceAccountKey.json");

const firebaseConfig = {
    credential: firebaseadmin.credential.cert(serviceAccount),
    databaseURL: "https://health-9cd54-default-rtdb.asia-southeast1.firebasedatabase.app"
};
const admindb = firebaseadmin.initializeApp(firebaseConfig);
const connectdb = firebaseapp.initializeApp(firebaseConfig);
const db = firebasedb.getDatabase();

module.exports = firebaseapp;
module.exports = firebaseadmin;
module.exports = firebasedb
module.exports = { get, set, ref };
module.exports = db;





// ---------------------------------------------------------------------------------------------------------------------------------------------------------

// const firebaseAdmin = require("firebase-admin");
// const serviceAccount = require("./serviceAccountKey.json");

// // Initialize Firebase Admin SDK
// firebaseAdmin.initializeApp({
//   credential: firebaseAdmin.credential.cert(serviceAccount),
//   databaseURL: "https://health-9cd54-default-rtdb.asia-southeast1.firebasedatabase.app"// Use your database URL
// });

// // If you need to use the Firebase client SDK, initialize it separately with appropriate config
// const firebaseApp = require('firebase/app');
// const firebaseDatabase = require('firebase/database');

// const firebaseConfig = {
//     apiKey: "your-api-key", // Your Firebase API key
//     authDomain: "your-auth-domain", // Your Firebase Auth domain
//     databaseURL: "https://your-database-url.firebaseio.com", // Your Firebase Database URL
//     projectId: "your-project-id", // Your Firebase project ID
//     // other config variables
// };

// // Initialize Firebase Client SDK
// const app = firebaseApp.initializeApp(firebaseConfig);
// const db = firebaseDatabase.getDatabase(app);

// module.exports = {
//     firebaseAdmin,
//     app, // Exporting the initialized client app
//     db, // Exporting the database reference for client SDK
//     // Export utility functions if needed
// };
