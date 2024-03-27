import 'package:client/Pages/volunteer_register/volunteer_test_2.dart';
import 'package:client/Pages/volunteer_register/volunteer_test_waiting.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:client/services/auth_service.dart';
import 'package:client/services/ip_variable.dart';
import 'package:client/pages/authentication/first_login/first_login_2.dart';
import '../../../component/buttons.dart';

class VolunteerTest3 extends StatefulWidget {
  const VolunteerTest3({Key? key}) : super(key: key);

  @override
  _VolunteerTest3State createState() => _VolunteerTest3State();
}

class _VolunteerTest3State extends State<VolunteerTest3> {
  bool agreedToTerms = false;
  String selectedGender = '';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
                width: MediaQuery.of(context).size.width - 32,
              ),
              Image.asset('assets/logos/medium_app_name.png'),
              const SizedBox(
                height: 37,
              ),
              Text(
                'แบบทดสอบอาสาสมัคร',
                style: FontTheme.subtitle1.copyWith(color: Colors.black),
              ),
              Image.asset('assets/images/Volunteer hat.png'),
              const SizedBox(height: 18),
              Text(
                'เมื่อผู้มาปรึกษาร้องไห้ Volunteer ควรปฏิบัติตนอย่างไร',
                style: FontTheme.subtitle2
                    .copyWith(color: ColorTheme.primaryColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 26.5),
              const Text(
                'คำตอบของคุณ: ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 35),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text(
                        'การให้คำแนะนำอย่างมืออาชีพ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'Male',
                        groupValue: selectedGender,
                        onChanged: (String? value) {
                          setState(() {
                            selectedGender = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'การรับฟังอย่างมีความเห็นอกเห็นใจ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'Female',
                        groupValue: selectedGender,
                        onChanged: (String? value) {
                          setState(() {
                            selectedGender = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'ความสามารถในการแก้ปัญหา',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'Others',
                        groupValue: selectedGender,
                        onChanged: (String? value) {
                          setState(() {
                            selectedGender = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'ทักษะการพูด',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'f',
                        groupValue: selectedGender,
                        onChanged: (String? value) {
                          setState(() {
                            selectedGender = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 50, left: 27, right: 27),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GoBackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VolunteerTest2(),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VolunteerTestWating(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: const Color.fromRGBO(72, 210, 104, 1),
                foregroundColor: Colors.white,
              ),
              child: const SizedBox(
                height: 40,
                width: 118,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ส่งคำตอบ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
