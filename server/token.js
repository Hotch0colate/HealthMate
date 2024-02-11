const { getAuth } = require('firebase-admin/auth');

getAuth()
  .verifyIdToken(idToken)
  .then((decodedToken) => {
    const uid = decodedToken.uid;
    // Use the uid to identify the user in your database or perform operations
  })
  .catch((error) => {
    console.log(idTokentoken);
    console.log(error.message)
    return res.status(410).json({ message: 'Invalid token' });
  });

  module.exports = verifyIdToken;