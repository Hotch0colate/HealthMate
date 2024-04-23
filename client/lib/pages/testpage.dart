import 'package:client/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import FadingCircle from flutter_spinkit

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingPsyRegister(),
    );
  }
}

class LoadingPsyRegister extends StatelessWidget {
  const LoadingPsyRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'กำลังตรวจสอบ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Stack(
              alignment: Alignment.center,
              children: [
                SpinKitFadingCircle( // FadingCircle loading animation
                  size: 200, // Adjust size as needed
                  color: ColorTheme.primaryColor,
                  duration: Durations.extralong4, 
                ),
                Image.asset(
                  'assets/images/psychiatrist_glasses.png',
                  width: 50,
                  fit: BoxFit.fill,
                ), // This will stay static on top
              ],
            ),
            SizedBox(height: 20),
            Text(
              'กรุณารอซักครู่ . . .',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
