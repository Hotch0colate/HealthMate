import 'package:client/component/navigation.dart';
import 'package:client/component/selected_card.dart';
import 'package:client/pages/psychiar_register/attach_cert.dart';
import 'package:client/pages/psychiar_register/finish_register.dart';
import 'package:client/pages/psychiar_register/loading_register.dart';
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

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PsySelectTag(),
    );
  }
}

class PsySelectTag extends StatefulWidget {
  const PsySelectTag({Key? key}) : super(key: key);

  @override
  _PsySelectTagState createState() => _PsySelectTagState();
}

class _PsySelectTagState extends State<PsySelectTag> {
  int selectedCardIndex = -1; // -1 indicates no card selected

  List<String> _tagOptions() =>
      ["Generic", "Responbility", "Relation", "Health"];

  // Future<void> sendUserDataToBackend(String gender) async {
  //   var _auth_service = AuthService();
  //   String? token = await _auth_service.getIdToken();
  //   var url = Uri.parse('http://${fixedIp}:3000/user/update_data');
  //   var response = await http.post(
  //     url,
  //     body: json.encode({'gender': gender}),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     print("Gender submitted successfully");
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const FirstLogin2(),
  //       ),
  //     );
  //   } else {
  //     print("Failed to submit gender: ${response.body}");
  //   }
  // }

  void _createPsy() async {}

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
                                style: FontTheme.h4.copyWith(
                                    color: ColorTheme
                                        .secondaryColor), // Black color for the first part of the text
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Image.asset(
                          'assets/images/psychiatrist_glasses.png',
                          height: 120,
                          width: 120,
                        ),
                        SizedBox(height: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'เลือกได้เพียง 1 หัวข้อเท่านั้น',
                              style: FontTheme.body1,
                            ),
                            SizedBox(height: 20),
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
                            SizedBox(height: 20),
                            Text(
                              '* สามารถเปลี่ยนแปลงได้ภายหลัง',
                              style: FontTheme.caption
                                  .copyWith(color: ColorTheme.warningAction),
                            )
                          ],
                        ),
                        // Align(
                        //   alignment: Alignment.bottomRight,
                        //   child: MdPrimaryButton(
                        //     text: 'ลงทะเบียน',
                        //     onPressed: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 const LoadingPsyRegister()),
                        //       );
                        //       Future.delayed(const Duration(seconds: 3), () {
                        //         _createPsy();
                        //         Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) =>
                        //                   const PsyCongrats()),
                        //         ); // Navigate back after 3 seconds
                        //       });
                        //     },
                        //     foregroundColor:
                        //         Colors.white, // Change text color
                        //     backgroundColor: ColorTheme.successAction,
                        //   ),
                        //   child: ForwardButton(
                        //     onPressed: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 const LoadingPsySelectTag()),
                        //       );
                        //       Future.delayed(const Duration(seconds: 3), () {
                        //         _createPsy();
                        //         Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) =>
                        //                   const PsyCongrats()),
                        //         ); // Navigate back after 3 seconds
                        //       });
                        //     },
                        //   ),
                        // ),
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
                    builder: (context) => AttachCertificate(),
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
                      builder: (context) => const LoadingPsyRegister()),
                );
                Future.delayed(const Duration(seconds: 3), () {
                  _createPsy();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FinishRegisterPsy()),
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
