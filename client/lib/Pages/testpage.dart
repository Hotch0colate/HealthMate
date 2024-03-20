import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthMate Calendar',
      home: PsyRegister(),
    );
  }
}

class PsyRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios, // Replace with your custom icon
            color: Colors.black26,
            size: 30, // Customize the icon color
          ),
          onPressed: () {},
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ลงทะเบียนจิตแพทย์', style: FontTheme.h4.copyWith(color: ColorTheme.secondaryColor)),
            SizedBox(height: 30), 
            Image.asset(
              'assets/psy/psy_cat.png', 
              height: 120,
            ),
            SizedBox(height: 20), 
            Text('ข้อตกลงการเป็นจิตแพทย์', style: FontTheme.body2.copyWith(color: ColorTheme.baseColor)),
            Image.asset(
              'assets/logos/small_app_name.png', 
            ),


          ],
        ),
      ),
    );
  }
}
