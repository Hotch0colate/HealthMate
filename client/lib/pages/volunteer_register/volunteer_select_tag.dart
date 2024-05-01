import 'package:client/component/navigation.dart';
import 'package:client/component/selected_card.dart';
import 'package:client/pages/volunteer_register/volunteer_congrats.dart';
import 'package:client/pages/volunteer_register/volunteer_register.dart';
import 'package:client/pages/volunteer_register/volunteer_test_waiting.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:client/services/auth_service.dart';
import 'package:client/services/ip_variable.dart';
import 'package:client/pages/authentication/first_login/first_login_2.dart';
import '../../../component/buttons.dart';

class VolunteerSelectTag extends StatefulWidget {
  const VolunteerSelectTag({Key? key}) : super(key: key);

  @override
  _VolunteerSelectTagState createState() => _VolunteerSelectTagState();
}

class _VolunteerSelectTagState extends State<VolunteerSelectTag> {
  int selectedCardIndex = -1; // -1 indicates no card selected
  bool _selectedGeneric = false;
  bool _selectedWork = false;
  bool _selectedRelationship = false;
  bool _selectedHealth = false;

  List<String> _tagOptions() =>
      ["Generic", "Responbility", "Relation", "Health"];

  Future<void> _createVolunteer() async {
    try {
      var _auth_service = AuthService();
      String? token = await _auth_service.getIdToken();

      List<String> selectedTags = [];
      if (_selectedGeneric) selectedTags.add('generic');
      if (_selectedWork) selectedTags.add('work');
      if (_selectedRelationship) selectedTags.add('relationship');
      if (_selectedHealth) selectedTags.add('health');

      var body = jsonEncode({'tags': selectedTags});

      final response = await http.post(
          Uri.parse('http://${fixedIp}:3000/volunteer/create_data'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token', // ส่ง token ใน header
          },
          body: body);

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to load emotions');
      }
    } catch (error) {
      throw Exception('Failed to load emotions: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.WhiteColor,
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 50,
                            )
                            //   IconButton(
                            //     icon: const Icon(
                            //       Icons
                            //           .arrow_back_ios, // Replace with your custom icon
                            //       color: Colors.black38,
                            //       size: 30, // Customize the icon color
                            //     ),
                            //     onPressed: () {
                            //       //กลับไปหน้า Select talk
                            //       //เปลี่ยน flow ตรงนี้ ตั้งเพื่อทดสอบการรันเฉยๆ
                            //       Navigator.pushAndRemoveUntil(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 MainApp(SelectedPage: 1)),
                            //         (Route<dynamic> route) =>
                            //             false, // Remove all routes below
                            //       );
                            //     },
                            //   ),
                          ],
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'เลือกหัวข้อที่จะให้คำปรึกษา',
                                style: FontTheme.subtitle1.copyWith(
                                    color: ColorTheme
                                        .primary2Color), // Black color for the first part of the text
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Image.asset(
                          'assets/images/volunteer_scarf.png',
                          height: 120,
                        ),
                        SizedBox(height: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'เลือกได้มากกว่า 1 หัวข้อ',
                              style: FontTheme.body1,
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MultipleSelectedCard(
                                  text: 'ทั่วไป',
                                  icon: Icons.emoji_emotions,
                                  onPressed: (isSelected) {
                                    print('Card 1 is selected: $isSelected');
                                    _selectedGeneric = isSelected;
                                  },
                                  isSelected: false,
                                  mainColor: ColorTheme.primary2Color,
                                ),
                                MultipleSelectedCard(
                                  text: 'ภาระหน้าที่',
                                  icon: Icons.work,
                                  onPressed: (isSelected) {
                                    print('Card 2 is selected: $isSelected');
                                    _selectedWork = isSelected;
                                  },
                                  isSelected: false,
                                  mainColor: ColorTheme.primary2Color,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MultipleSelectedCard(
                                  text: 'ความสัมพันธ์',
                                  icon: CupertinoIcons.person_3_fill,
                                  onPressed: (isSelected) {
                                    print('Card 3 is selected: $isSelected');
                                    _selectedRelationship = isSelected;
                                  },
                                  isSelected: false,
                                  mainColor: ColorTheme.primary2Color,
                                ),
                                MultipleSelectedCard(
                                  text: 'สุขภาพ',
                                  icon: CupertinoIcons.heart_fill,
                                  onPressed: (isSelected) {
                                    print('Card 4 is selected: $isSelected');
                                    _selectedHealth = isSelected;
                                  },
                                  isSelected: false,
                                  mainColor: ColorTheme.primary2Color,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              '* สามารถเปลี่ยนแปลงได้ภายหลัง',
                              style: FontTheme.caption
                                  .copyWith(color: ColorTheme.warningAction),
                            )
                          ],
                        ),
                      ])))),
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
                    builder: (context) => const VolunteerRegister(),
                  ),
                );
              },
            ),
            MdPrimaryButton(
              text: 'ลงทะเบียน',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoadingVolunteerRegister()),
                );
                Future.delayed(const Duration(seconds: 3), () {
                  _createVolunteer();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VolunteerCongrats()),
                  ); // Navigate back after 3 seconds
                });
              },
              foregroundColor: Colors.white, // Change text color
              backgroundColor: ColorTheme.successAction,
            ),
          ],
        ),
      ),
    );
  }
}
