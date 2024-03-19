import 'package:shared_preferences/shared_preferences.dart';
import 'package:client/services/ip_variable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String _backendUrl = 'http://${fixedIp}:3000/access/signin';

  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> getToken() async {
    //sharedToken
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    // Navigate to login or perform other actions as needed
  }

  // Method to get the current user's ID token
  Future<String?> getIdToken() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      String? idToken = await user.getIdToken();
      return idToken;
    }
    return null;
  }

  // Method to send the ID token to your backend for verification
  Future<void> sendTokenToBackend(String? token) async {
    if (token != null) {
      print('Sending token to backend....');
      final response = await http.post(
        Uri.parse(_backendUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Handle successful token verification
        print("Token verified successfully with backend.");
      } else {
        // Handle errors or unsuccessful token verification
        print("Failed to verify token with backend.");
        print("response.statusCode: ${response.statusCode}");
      }
    }
  }

  // Utility method that combines getting the ID token and sending it to the backend
  Future<void> authenticateWithBackend() async {
    String? idToken = await getIdToken();
    if (idToken != null) {
      await sendTokenToBackend(idToken);
    } else {
      // Handle the case where the ID token is null (e.g., user not logged in)
      print("No ID token available. User might not be logged in.");
    }
  }
}
