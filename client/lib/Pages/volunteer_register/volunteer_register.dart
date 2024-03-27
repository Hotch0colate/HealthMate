import 'package:client/Pages/volunteer_register/volunteer_test_1.dart';
import 'package:client/Pages/volunteer_register/volunteer_test_2.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:client/services/auth_service.dart';
import 'package:client/services/ip_variable.dart';
import 'package:client/pages/authentication/first_login/first_login_2.dart';
import '../../../component/buttons.dart';

class VolunteerRegister extends StatefulWidget {
  const VolunteerRegister({Key? key}) : super(key: key);

  @override
  _VolunteerRegisterState createState() => _VolunteerRegisterState();
}

class _VolunteerRegisterState extends State<VolunteerRegister> {
  bool agreedToTerms = false;
  String selectedGender = '';

  Map<String, bool> selectedOptions = {
    'stopCrying': false,
    'comfortEncourage': false,
    'waitSilently': false,
    'suggestSolutions': false,
  };

  Future<void> sendUserDataToBackend(String gender) async {
    var _auth_service = AuthService();
    String? token = await _auth_service.getIdToken();
    var url = Uri.parse('http://${fixedIp}:3000/user/update_data');
    var response = await http.post(
      url,
      body: json.encode({'gender': gender}),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print("Gender submitted successfully");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FirstLogin2(),
        ),
      );
    } else {
      print("Failed to submit gender: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Image.asset('assets/icons/back_new.png',
                width: 35, fit: BoxFit.contain),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'ลงทะเบียน',
                      style: FontTheme.h3.copyWith(color: ColorTheme.baseColor),
                    ),
                    TextSpan(
                      text: 'อาสาสมัคร',
                      style: FontTheme.h3
                          .copyWith(color: ColorTheme.primary2Color),
                    ),
                  ],
                ),
              ),
              Image.asset('assets/images/Volunteer hat.png'),
              SizedBox(height: screenHeight * 0.01), // 5% of screen height
              Text(
                'ข้อตกลงการเป็นอาสาสมัคร',
                style: FontTheme.body1.copyWith(color: ColorTheme.baseColor),
              ),
              Image.asset('assets/logos/medium_app_name.png'),
              SizedBox(height: screenHeight * 0.01),
              Container(
                padding: const EdgeInsets.only(left: 35),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text(
                        'บอกให้หยุดร้องไห้',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      leading: Checkbox(
                        value: selectedOptions['stopCrying'],
                        onChanged: (bool? value) {
                          setState(() {
                            selectedOptions['stopCrying'] = value!;
                          });
                        },
                        activeColor: ColorTheme.primaryColor,
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'ปลอบโยนหรือให้กำลังใจ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      leading: Checkbox(
                        value: selectedOptions['comfortEncourage'],
                        onChanged: (bool? value) {
                          setState(() {
                            selectedOptions['comfortEncourage'] = value!;
                          });
                        },
                        activeColor: ColorTheme.primaryColor,
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'เงียบแล้วรอให้ผู้มาปรึกษาสงบลง',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      leading: Checkbox(
                        value: selectedOptions['waitSilently'],
                        onChanged: (bool? value) {
                          setState(() {
                            selectedOptions['waitSilently'] = value!;
                          });
                        },
                        activeColor: ColorTheme.primaryColor,
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'แนะนำวิธีแก้ปัญหาให้ผู้มาปรึกษา',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      leading: Checkbox(
                        value: selectedOptions['suggestSolutions'],
                        onChanged: (bool? value) {
                          setState(() {
                            selectedOptions['suggestSolutions'] = value!;
                          });
                        },
                        activeColor: ColorTheme.primaryColor,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LgPrimaryButton(
              text: "เริ่มทำแบบทดสอบ",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VolunteerTest1(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
