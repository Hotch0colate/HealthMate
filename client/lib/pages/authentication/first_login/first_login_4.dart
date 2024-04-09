import 'package:client/component/select_box.dart';
import 'package:client/pages/authentication/first_login/first_login_3.dart';
import 'package:client/pages/authentication/first_login/first_login_5.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/pages/authentication/login.dart';
import 'package:client/component/buttons.dart';
import 'package:client/services/ip_variable.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:client/services/save_state_first_login.dart';

class FirstLogin4 extends StatefulWidget {
  const FirstLogin4({Key? key});

  @override
  _FirstLogin4State createState() => _FirstLogin4State();
}

class _FirstLogin4State extends State<FirstLogin4> {
  bool agreedToTerms = false;
  String selectedMartialStatusValue = '';

  Future<void> sendDataToBackend(String martial_status) async {
    var _auth_service = AuthService();
    String? token = await _auth_service.getIdToken();

    var url = Uri.parse('http://${fixedIp}:3000/user/update_data');
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode({"martialstatus": martial_status, 'firstloginstage': 5}),
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FirstLogin5(),
        ),
      );
    } else {
      throw Exception('Failed to load data');
    }
  }

  String? selectedMartialStatus;

  Widget _buildRadioListTile({required String title, required String value}) {
    return ListTile(
      dense: true,
      title: Text(
        title,
        style: TextStyle(
          color: selectedMartialStatus == value ? Colors.orange : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins',
        ),
      ),
      leading: Radio<String>(
        value: value,
        groupValue: selectedMartialStatus,
        onChanged: (String? value) {
          setState(() {
            selectedMartialStatus = value;
            selectedMartialStatusValue = value!;
          });
        },
        activeColor: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 32,
              ),
              Image.asset('assets/logos/large_app_name.png'),
              const SizedBox(height: 24),
              const SizedBox(
                height: 72,
                child: Image(
                  image: AssetImage('assets/logos/main_mascot.png'),
                ),
              ),
              const SizedBox(height: 18),
              Text('สถานะของคุณคืออะไรครับ?',
                  style: FontTheme.subtitle1
                      .copyWith(color: ColorTheme.primaryColor)),
              const SizedBox(height: 24),
              Text('คำตอบของคุณ: ', style: FontTheme.body1),
              const SizedBox(height: 12),
              // Radio buttons for gender selection
              Container(
                padding: const EdgeInsets.only(left: 35),
                child: Column(
                  children: [
                    ColorChangingRadio(
                      text: 'โสด',
                      value: 'Single',
                      groupValue: selectedMartialStatusValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedMartialStatus = value;
                          selectedMartialStatusValue = value!;
                        });
                      },
                    ),
                    ColorChangingRadio(
                      text: 'มีแฟนแล้ว',
                      value: 'Partnered',
                      groupValue: selectedMartialStatusValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedMartialStatus = value;
                          selectedMartialStatusValue = value!;
                        });
                      },
                    ),
                    ColorChangingRadio(
                      text: 'หมั้นแล้ว / แต่งงานแล้ว',
                      value: 'Married',
                      groupValue: selectedMartialStatusValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedMartialStatus = value;
                          selectedMartialStatusValue = value!;
                        });
                      },
                    ),
                    ColorChangingRadio(
                      text: 'ม่าย / หย่าร้าง / แยกกันอยู่',
                      value: 'Divorced',
                      groupValue: selectedMartialStatusValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedMartialStatus = value;
                          selectedMartialStatusValue = value!;
                        });
                      },
                    ),
                    ColorChangingRadio(
                      text: 'อยู่ในความสัมพันธ์แบบไม่ผูกมัด',
                      value: 'NonBindingRelationship',
                      groupValue: selectedMartialStatusValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedMartialStatus = value;
                          selectedMartialStatusValue = value!;
                        });
                      },
                    ),
                    ColorChangingRadio(
                      text: 'ค่อนข้างอธิบายยาก',
                      value: 'Complicated',
                      groupValue: selectedMartialStatusValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedMartialStatus = value;
                          selectedMartialStatusValue = value!;
                        });
                      },
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
            GoBackButton(onPressed: () {
              setStateFirstLogin(context, 3, FirstLogin3());
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => FirstLogin3(),
              //   ),
              // );
            }),
            ForwardButton(onPressed: () {
              if (selectedMartialStatusValue.isNotEmpty) {
                sendDataToBackend(selectedMartialStatusValue);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FirstLogin5()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please select an Status"),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
