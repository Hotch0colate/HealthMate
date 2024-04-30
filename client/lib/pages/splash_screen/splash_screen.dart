import 'package:client/services/auth_service.dart';
import 'package:client/services/ip_variable.dart';
import 'package:client/theme/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:client/Pages/authentication/login.dart';
import 'package:client/pages/authentication/signup.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay to display the splash screen for 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      // // Navigate to the main screen after the splash screen is displayed
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => LoginPage(),
      //   ),
      // );
      checkLoggedInState();
    });
  }

  Future<int> fetchFirstloginstageFromToken(String? token) async {
    final response = await http.get(
      Uri.parse(
          'http://${fixedIp}:3000/user/read_data'), // แทนที่ด้วย URL จริงของ backend ของคุณ
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // ส่ง token ใน header
      },
    );
    // print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(
          "Response JSON: $jsonResponse"); // This line will print the entire response

      // Assuming 'firstloginstage' is an integer in the JSON response
      int firstLoginStage = jsonResponse['Data']['firstloginstage'] ??
          99; // Default to 99 if not set

      print(
          "First login stage: $firstLoginStage"); // This will show the parsed or default value
      return firstLoginStage;
    } else {
      // หากการตอบกลับไม่สำเร็จ, โยน exception
      throw Exception('Failed to load uid from token, splash screen page');
    }
  }

  void checkLoggedInState() async {
    String? sharedToken = await AuthService().getToken();
    String? token = await AuthService().getIdToken();
    if (sharedToken != null) {
      // Token exists, so navigate to the main app screen
      // print("Token:" + token);
      int userState = await fetchFirstloginstageFromToken(token);
      print("userState = " + userState.toString());
      if (userState == 0 || userState == 1) {
        Navigator.of(context).pushReplacementNamed('/first_login');
      } else if (userState < 0 || (userState > 5 && userState != 99)) {
        throw Exception('Invalid first login state');
      } else if (userState == 99) {
        Navigator.of(context).pushReplacementNamed('/main');
      } else if (userState == 2) {
        Navigator.of(context).pushReplacementNamed('/first_login_2');
      } else if (userState == 3) {
        Navigator.of(context).pushReplacementNamed('/first_login_3');
      } else if (userState == 4) {
        Navigator.of(context).pushReplacementNamed('/first_login_4');
      } else if (userState == 5) {
        Navigator.of(context).pushReplacementNamed('/first_login_5');
      }
    } else {
      // No token, so navigate to the login screen
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.WhiteColor,
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 255, 253, 247)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logos/main_mascot.png',
              ),
              SizedBox(height: 20),
              Image.asset(
                'assets/logos/large_app_name.png',
                width: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
