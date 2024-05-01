import 'package:client/Pages/select_talk/find_volunteer_page.dart';
import 'package:client/component/buttons.dart';
import 'package:client/component/dialog.dart';
import 'package:client/component/navigation.dart';
import 'package:client/component/selected_card.dart';
import 'package:client/component/text_field/text_field.dart';
import 'package:client/pages/psychiar_register/register.dart';
import 'package:client/pages/select_talk/find_psy_page.dart';
import 'package:client/pages/volunteer_register/volunteer_register.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:client/services/auth_service.dart';
import 'package:client/services/ip_variable.dart';
import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: CreateTagPsyPage(),
//     );
//   }
// }

class CreateTagPsyPage extends StatefulWidget {
  const CreateTagPsyPage({Key? key});

  @override
  _CreateTagPsyPageState createState() => _CreateTagPsyPageState();
}

class _CreateTagPsyPageState extends State<CreateTagPsyPage> {
  bool isPsychiatrist = false; // Track psychiatrist status
  String psychiatristUid = '';

  int selectedCardIndex = -1; // -1 indicates no card selected

  final _formKey = GlobalKey<FormState>();

  TextEditingController descriptionTextController = TextEditingController();

  List<String> _tagOptions() => ["generic", "work", "relationship", "health"];

  void _fetchAndSetPUid() async {
    String _PyschiatristUid = await checkIfPsychiatrist();
    print(_PyschiatristUid);
    if (_PyschiatristUid != '' && isPsychiatrist == true) {
      setState(() {
        psychiatristUid = _PyschiatristUid;
        print(psychiatristUid);
      });
    }
  }

  Future<String> checkIfPsychiatrist() async {
    var _auth_service = AuthService();
    String? token = await _auth_service.getIdToken();
    var url = Uri.parse('http://${fixedIp}:3000/psychiatrist/check_data');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      String respMessage = jsonDecode(response.body)['RespMessage'];
      if (respMessage == "Success") {
        isPsychiatrist = true;
        return respMessage = jsonDecode(response.body)['uid'];
      }
      return '';
    } else if (response.statusCode == 404) {
      print("Not psychiatrist: ${response.body}");
      return '';
    } else {
      print("Failed to submit data: ${response.body}");
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAndSetPUid();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorTheme.WhiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios, // Replace with your custom icon
                      color: Colors.black38,
                      size: 30, // Customize the icon color
                    ),
                    onPressed: () {
                      // Navigate back to the previous screen
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainApp(SelectedPage: 1)),
                        (Route<dynamic> route) =>
                            false, // Remove all routes below
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/images/psychiatrist_glasses.png',
                    width: 100,
                    height: 100,
                  ),
                  Text(
                    'เลือกเรื่องที่จะปรึกษา\nได้เลย เมี๊ยววว...',
                    style: FontTheme.subtitle1
                        .copyWith(color: ColorTheme.secondaryColor),
                  )
                ],
              ),
              const SizedBox(height: 36),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SelectedCard(
                        text: 'ทั่วไป',
                        icon: Icons.emoji_emotions,
                        onPressed: () {
                          setState(() {
                            selectedCardIndex = 0;
                          });
                        },
                        isSelected: selectedCardIndex == 0,
                        mainColor: ColorTheme.secondaryColor,
                      ),
                      SelectedCard(
                        text: 'ภาระหน้าที่',
                        icon: Icons.work,
                        onPressed: () {
                          setState(() {
                            selectedCardIndex = 1;
                          });
                        },
                        isSelected: selectedCardIndex == 1,
                        mainColor: ColorTheme.secondaryColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SelectedCard(
                        text: 'ความสัมพันธ์',
                        icon: CupertinoIcons.person_3_fill,
                        onPressed: () {
                          setState(() {
                            selectedCardIndex = 2;
                          });
                        },
                        isSelected: selectedCardIndex == 2,
                        mainColor: ColorTheme.secondaryColor,
                      ),
                      SelectedCard(
                        text: 'สุขภาพ',
                        icon: CupertinoIcons.heart_fill,
                        onPressed: () {
                          setState(() {
                            selectedCardIndex = 3;
                          });
                        },
                        isSelected: selectedCardIndex == 3,
                        mainColor: ColorTheme.secondaryColor,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.01),
                    child: Text(
                      'รายละเอียด',
                      style: FontTheme.subtitle2.copyWith(color: Colors.black),
                    ),
                  )
                ],
              ),
              SizedBox(height: screenHeight * 0.005),
              MultilineInputTextField(
                controller: descriptionTextController,
                hintText: 'ใส่รายละเอียด',
              ),
              const SizedBox(height: 28),
              MdPrimaryButton(
                minWidth: 400,
                text: 'ค้นหาจิตแพทย์',
                onPressed: () {
                  if (selectedCardIndex != -1 &&
                      selectedCardIndex >= 0 &&
                      descriptionTextController.text.length > 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FindPsyPage(
                          // selectedTag: _tagOptions()[selectedCardIndex],
                          text: descriptionTextController.text,
                          selectedTag: _tagOptions()[selectedCardIndex],
                        ),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: ColorTheme.WhiteColor,
                          title: Text("Error"),
                          content: Text(
                            "กรุณาเลือกหัวข้อที่จะปรึกษาและกรอกรายละเอียดก่อนกดค้นหา",
                            style: FontTheme.caption,
                          ),
                          actions: <Widget>[
                            SmPrimaryButton(
                                text: 'ตกลง',
                                onPressed: () {
                                  Navigator.pop(context);
                                })
                          ],
                        );
                      },
                    );
                  }
                },
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      thickness: 1.5,
                      color: ColorTheme.secondaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'มาเป็นจิตแพทย์ด้วยกันไหมครับ',
                      style: FontTheme.body1
                          .copyWith(color: ColorTheme.secondaryColor),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      thickness: 1.5,
                      color: ColorTheme.secondaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              isPsychiatrist
                  ? MdSecondaryButton(
                      minWidth: 400,
                      text: 'เปลี่ยน/ยกเลิกจิตแพทย์', // Change button text
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CancleRoleDialog(
                              textRole: 'ยกเลิกการเป็นจิตแพทย์',
                              apiLine: 'psychiatrist',
                              roleId: psychiatristUid,
                            );
                          },
                        );
                      },
                      borderColor: ColorTheme.errorAction,
                      foregroundColor: ColorTheme.errorAction,
                    )
                  : MdSecondaryButton(
                      minWidth: 400,
                      text: 'ลงทะเบียนจิตแพทย์', // Original button text
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PsyRegister(),
                          ),
                        );
                      },
                      borderColor: ColorTheme.secondaryColor,
                      foregroundColor: ColorTheme.secondaryColor,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
