// Import Firebase Admin SDK
var firebaseAdmin = require("firebase-admin");

// Middleware to authenticate requests
const authenticate = async (req, res, next) => {
  // Check for ID token in Authorization header
  const header = req.headers.authorization;
  if (!header || !header.startsWith('Bearer ')) {
    return res.status(401).json({ message: "No token provided" });
  }

  const idToken = header.split('Bearer ')[1];

  try {
    // Verify ID token using Firebase Admin SDK
    const decodedToken = await firebaseAdmin.auth().verifyIdToken(idToken);
    req.user = decodedToken; // Attach decoded token to request object
    console.log("User authenticated decodeToken:", decodedToken);
    console.log("User authenticated req.user:", req.user.uid);
    userUID = req.user.uid;
    next(); // Proceed to the next middleware or route handler
  } catch (error) {
    console.error("Error verifying token:", error);
    res.status(403).json({ message: "Invalid token" });
  }
};

module.exports = authenticate;