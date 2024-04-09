import 'package:client/component/select_box.dart';
import 'package:client/pages/authentication/first_login/first_login_4.dart';
import 'package:client/component/buttons.dart';
import 'package:client/services/ip_variable.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:client/pages/authentication/first_login/first_login_2.dart';
import 'package:client/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FirstLogin3 extends StatefulWidget {
  const FirstLogin3({Key? key}) : super(key: key);

  @override
  _FirstLogin3State createState() => _FirstLogin3State();
}

class _FirstLogin3State extends State<FirstLogin3> {
  bool agreedToTerms = false;
  String selectedCareerValue = '';
  String? selectedCareer;

  Future<void> sendDataToBackend(String career) async {
    var _auth_service = AuthService();
    String? token = await _auth_service.getIdToken();

    var url = Uri.parse('http://${fixedIp}:3000/user/update_data');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({"career": career}),
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FirstLogin4(),
        ),
      );
    } else {
      throw Exception('Failed to load data');
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
              Text('คุณทำงานอาชีพอะไรครับ ?',
                  style: FontTheme.subtitle1
                      .copyWith(color: ColorTheme.primaryColor)),
              const SizedBox(height: 24),
              Text('คำตอบของคุณ: ', style: FontTheme.body1),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.only(left: 35),
                child: Column(
                  children: <Widget>[
                    ColorChangingRadio(
                      text: 'นักเรียน/นิสิตนักศึกษา',
                      value: 'Student',
                      groupValue: selectedCareerValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedCareer = value;
                          selectedCareerValue = value!;
                        });
                      },
                    ),
                    ColorChangingRadio(
                      text: 'พนักงานบริษัทเอกชน',
                      value: 'OfficeWorker',
                      groupValue: selectedCareerValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedCareer = value;
                          selectedCareerValue = value!;
                        });
                      },
                    ),
                    ColorChangingRadio(
                      text: 'พนักงานข้าราชการ',
                      value: 'PublicServant',
                      groupValue: selectedCareerValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedCareer = value;
                          selectedCareerValue = value!;
                        });
                      },
                    ),
                    ColorChangingRadio(
                      text: 'พนักงานรัฐวิสาหกิจ',
                      value: 'StateEnterpriseEmployee',
                      groupValue: selectedCareerValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedCareer = value;
                          selectedCareerValue = value!;
                        });
                      },
                    ),
                    ColorChangingRadio(
                      text: 'พนักงานโรงงานอุตสาหกรรม',
                      value: 'IndustryWorker',
                      groupValue: selectedCareerValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedCareer = value;
                          selectedCareerValue = value!;
                        });
                      },
                    ),
                    ColorChangingRadio(
                      text: 'เจ้าของธุรกิจ/ธุรกิจส่วนตัว',
                      value: 'PrivateBusiness',
                      groupValue: selectedCareerValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedCareer = value;
                          selectedCareerValue = value!;
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
            GoBackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FirstLogin2(),
                  ),
                );
              },
            ),
            ForwardButton(
              onPressed: () {
                if (selectedCareerValue.isNotEmpty) {
                  sendDataToBackend(selectedCareerValue);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FirstLogin4(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select an Occupation"),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
