import 'package:client/Pages/volunteer_register/volunteer_test_1.dart';
import 'package:client/Pages/volunteer_register/volunteer_test_2.dart';
import 'package:client/component/navigation.dart';
import 'package:client/component/select_box.dart';
import 'package:client/pages/select_talk/create_tag_page_volunteer.dart';
import 'package:client/pages/volunteer_register/volunteer_congrats.dart';
import 'package:client/pages/volunteer_register/volunteer_select_tag.dart';
import 'package:client/pages/volunteer_register/volunteer_test_waiting.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:client/services/auth_service.dart';
import 'package:client/services/ip_variable.dart';
import 'package:client/pages/authentication/first_login/first_login_2.dart';
import '../../../component/buttons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VolunteerRegister(),
    );
  }
}

class VolunteerRegister extends StatefulWidget {
  const VolunteerRegister({Key? key}) : super(key: key);

  @override
  _VolunteerRegisterState createState() => _VolunteerRegisterState();
}

class _VolunteerRegisterState extends State<VolunteerRegister> {
  bool agreedToTerms = false;
  bool agreedToPrivacy = false;
  bool agreedToRespect = false;

  // Function to check if all checkboxes are checked

  // Map<String, bool> selectedOptions = {
  //   'stopCrying': false,
  //   'comfortEncourage': false,
  //   'waitSilently': false,
  //   'suggestSolutions': false,
  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            // SizedBox(height: 50,)
                            IconButton(
                              icon: const Icon(
                                Icons
                                    .arrow_back_ios, // Replace with your custom icon
                                color: Colors.black38,
                                size: 30, // Customize the icon color
                              ),
                              onPressed: () {
                                //กลับไปหน้า Select talk
                                //เปลี่ยน flow ตรงนี้ ตั้งเพื่อทดสอบการรันเฉยๆ
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MainApp(SelectedPage: 1)),
                                  (Route<dynamic> route) =>
                                      false, // Remove all routes below
                                );
                              },
                            ),
                          ],
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'ลงทะเบียน',
                                style: FontTheme.h4.copyWith(
                                    color: ColorTheme
                                        .baseColor), // Black color for the first part of the text
                              ),
                              TextSpan(
                                text: 'อาสาสมัคร',
                                style: FontTheme.h4.copyWith(
                                    color: ColorTheme
                                        .primary2Color), // Secondary color for the second part of the text
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Image.asset(
                          'assets/images/volunteer_scarf.png',
                          height: 120,
                          width: 100,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'ข้อตกลงการเป็นอาสาสมัคร',
                          style: FontTheme.subtitle2,
                        ),
                        Image.asset(
                          'assets/logos/small_app_name.png',
                        ),
                        SizedBox(height: 20),
                        ColorChangingCheckbox(
                          key: UniqueKey(),
                          text: 'ข้าพเจ้าจะปฏิบัติหน้าที่อาสาสมัครอย่างเต็มที่',
                          onChanged: (bool value) {
                            // Callback when checkbox state changes
                            setState(() {
                              agreedToTerms =
                                  value; // Update the state when the checkbox state changes
                            });
                          },
                          value: agreedToTerms,
                        ),
                        SizedBox(height: 10),
                        ColorChangingCheckbox(
                          key: UniqueKey(),
                          text:
                              'ข้าพเจ้าจะเก็บรักษาความลับของอีกฝ่าย\nอย่างเคร่งครัด',
                          onChanged: (bool value) {
                            setState(() {
                              agreedToPrivacy =
                                  value; // Update the state when the checkbox state changes
                            });
                          },
                          value: agreedToPrivacy,
                        ),
                        SizedBox(height: 10),
                        ColorChangingCheckbox(
                          key: UniqueKey(),
                          text:
                              'ข้าพเจ้าจะให้เกียรติอีกฝ่ายและให้คำปรึกษา\nแบบเชิงบวก',
                          onChanged: (bool value) {
                            setState(() {
                              agreedToRespect =
                                  value; // Update the state when the checkbox state changes
                            });
                          },
                          value: agreedToRespect,
                        ),

                        SizedBox(height: 50),
                        // Align(
                        //   alignment: Alignment.bottomRight,
                        //   child: MdPrimaryButton(
                        //     text: 'ลงทะเบียน',
                        //     onPressed: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 const LoadingVolunteerRegister()),
                        //       );
                        //       Future.delayed(const Duration(seconds: 3), () {
                        //         _createPsychiatrist();
                        //         Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) =>
                        //                   const VolunteerCongrats()),
                        //         ); // Navigate back after 3 seconds
                        //       });
                        //     },
                        //     foregroundColor:
                        //         Colors.white, // Change text color
                        //     backgroundColor: ColorTheme.successAction,
                        //   ),
                        // child: ForwardButton(
                        //   onPressed: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) =>
                        //               const VolunteerSelectTag()),
                        //     );

                        //     },
                        //   ),
                        // ),
                      ])))),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 50, left: 27, right: 27),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // GoBackButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const CreateTagVolunteerPage(),
            //       ),
            //     );
            //   },
            // ),
            ForwardButton(
              // Disable the button if not all checkboxes are checked
              onPressed: () {
                if (agreedToTerms && agreedToPrivacy && agreedToRespect) {
                  // Navigate to the next page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VolunteerSelectTag(),
                    ),
                  );
                } else {
                  // Show a dialog or snackbar indicating that all checkboxes must be checked
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Error"),
                        content: Text("กรุณายอมรับข้อตกลงก่อนกด ต่อไป"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
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
