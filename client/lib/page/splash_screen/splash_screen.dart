import 'package:client/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:client/Pages/authentication/login.dart';
import 'package:client/pages/authentication/signup.dart';
import 'package:flutter/material.dart';

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

  void checkLoggedInState() async {
    String? token = await AuthService().getToken();
    print("Shared Token: " + token.toString());
    if (token != null) {
      // Token exists, so navigate to the main app screen
      // print("Token:" + token);
      Navigator.of(context).pushReplacementNamed('/main');
    } else {
      // No token, so navigate to the login screen
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
