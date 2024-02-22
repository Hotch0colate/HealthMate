import 'package:client/pages/signup.dart';
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
    Future.delayed(Duration(seconds: 10), () {
      // Navigate to the main screen after the splash screen is displayed
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignupPage(),
        ),
      );
    });
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
                '../assets/logos/main_mascot.png',
              ),
              SizedBox(height: 20),
              Image.asset(
                '../assets/logos/large_app_name.png',
                width: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
