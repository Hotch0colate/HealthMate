// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously, file_names

import 'package:client/component/select_box.dart';
import 'package:client/component/text_field/text_field.dart';
import 'package:client/pages/authentication/first_login/first_login_2.dart';
import 'package:client/pages/authentication/login.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

import 'package:client/component/text_field/grey_text_field.dart';
import 'package:client/component/buttons.dart';
import 'package:client/component/text_field/password_field.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthMate',
      home: FirstLogin1(),
    );
  }
}

class FirstLogin1 extends StatefulWidget {
  const FirstLogin1({Key? key}) : super(key: key);

  @override
  _FirstLogin3State createState() => _FirstLogin3State();
}

class _FirstLogin3State extends State<FirstLogin1> {
  bool agreedToTerms = false;
  String selectedGender = ''; // Variable to store selected gender

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 51,
                width: MediaQuery.of(context).size.width - 32,
              ),
              Image.asset('assets/logos/big_app_name.png'),
              const SizedBox(
                height: 37,
              ),
              const SizedBox(
                height: 86,
                child: Image(
                  image: AssetImage(
                    'assets/logos/main_mascot.png',
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'เพศของคุณคืออะไร ?',
                style: FontTheme.subtitle1.copyWith(color: ColorTheme.primaryColor)
              ),
              const SizedBox(height: 26.5),
              Text(
                'คำตอบของคุณ: ',
                style: FontTheme.body1
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.only(left: 35),
                child: Column(
                  children: [
                    ColorChangingRadio(
                      text: 'หญิง', 
                      value: 'Female', 
                      groupValue: selectedGender, 
                      onChanged: (String? value) {
                          setState(() {
                            selectedGender = value!;
                          });
                        },
                      ),
                      ColorChangingRadio(
                      text: 'ชาย', 
                      value: 'Male', 
                      groupValue: selectedGender, 
                      onChanged: (String? value) {
                          setState(() {
                            selectedGender = value!;
                          });
                        },
                      ),
                      ColorChangingRadio(
                      text: 'อื่น ๆ', 
                      value: 'Others', 
                      groupValue: selectedGender, 
                      onChanged: (String? value) {
                          setState(() {
                            selectedGender = value!;
                          });
                        },
                      )
                  ],
                ),
              ),
              // const SizedBox(height: 60),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 50, left: 27, right: 27),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 40,
              width: 118,
            ),
            ForwardButton(
              onPressed: () {
                if (selectedGender.isNotEmpty) {
                  sendUserDataToBackend(selectedGender);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FirstLogin2()),
                  );
                } else {
                  // Prompt user to select a gender or handle this case accordingly
                  print("Please select a gender");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
  
  void sendUserDataToBackend(String selectedGender) {}
}
