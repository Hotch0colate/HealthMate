import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import FadingCircle from flutter_spinkit

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingVolunteerRegister(),
    );
  }
}

class LoadingVolunteerRegister extends StatelessWidget {
  const LoadingVolunteerRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.WhiteColor,
      body: Center(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,// Center content horizontally
              children: [
                Text(
                  'กำลังตรวจสอบ',
                  style: FontTheme.h3.copyWith(color: ColorTheme.primaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                  const SpinKitCircle( // FadingCircle loading animation
                  size: 280, // Adjust size as needed
                  color: ColorTheme.primaryColor,
                  duration: Durations.extralong4, 
                ),// This will display the animation
                    Image.asset(
                      'assets/images/volunteer_scarf.png',
                      width: 100,
                      fit: BoxFit.fill,
                    ), // This will stay static on top
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'กรุณารอซักครู่ . . .',
                  style: FontTheme.subtitle1.copyWith(color: ColorTheme.secondaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}