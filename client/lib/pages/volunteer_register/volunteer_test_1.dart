// import 'package:client/Pages/volunteer_register/volunteer_register.dart';
// import 'package:client/Pages/volunteer_register/volunteer_test_2.dart';
// import 'package:client/component/select_box.dart';
// import 'package:client/theme/color.dart';
// import 'package:client/theme/font.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:client/services/auth_service.dart';
// import 'package:client/services/ip_variable.dart';
// import 'package:client/pages/authentication/first_login/first_login_2.dart';
// import '../../../component/buttons.dart';

// class VolunteerTest1 extends StatefulWidget {
//   const VolunteerTest1({Key? key}) : super(key: key);

//   @override
//   _VolunteerTest1State createState() => _VolunteerTest1State();
// }

// class _VolunteerTest1State extends State<VolunteerTest1> {
//   bool agreedToTerms = false;
//   String selectedGender = '';

//   // Future<void> sendUserDataToBackend(String gender) async {
//   //   var _auth_service = AuthService();
//   //   String? token = await _auth_service.getIdToken();
//   //   var url = Uri.parse('http://${fixedIp}:3000/user/update_data');
//   //   var response = await http.post(
//   //     url,
//   //     body: json.encode({'gender': gender}),
//   //     headers: {
//   //       'Content-Type': 'application/json',
//   //       'Authorization': 'Bearer $token',
//   //     },
//   //   );

//   //   if (response.statusCode == 200) {
//   //     print("Gender submitted successfully");
//   //     Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //         builder: (context) => const FirstLogin2(),
//   //       ),
//   //     );
//   //   } else {
//   //     print("Failed to submit gender: ${response.body}");
//   //   }
//   // }
  
//    Map<String, bool> selectedOptions = {
//     'stopCrying': false,
//     'comfortEncourage': false,
//     'waitSilently': false,
//     'suggestSolutions': false,
//   };

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 20,
//                 width: MediaQuery.of(context).size.width - 32,
//               ),
//               Image.asset('assets/logos/medium_app_name.png'),
//               const SizedBox(
//                 height: 37,
//               ),
//               Text(
//                 'แบบทดสอบอาสาสมัคร',
//                 style: FontTheme.subtitle1.copyWith(color: Colors.black),
//               ),
//               Image.asset('assets/images/Volunteer hat.png'),
//               const SizedBox(height: 18),
//               Text(
//                 'เมื่อผู้มาปรึกษาร้องไห้ Volunteer ควรปฏิบัติตนอย่างไร',
//                 style: FontTheme.subtitle2
//                     .copyWith(color: ColorTheme.primaryColor),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: screenHeight * 0.01), // 5% of screen height
//               const Text(
//                 'คำตอบของคุณ: ',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.only(left: 35),
//                 child: Column(
//                   children: [
//                     ColorChangingRadio(
//                       text: 'หญิง',
//                       value: 'Female',
//                       groupValue: selectedGender,
//                       onChanged: (String? value) {
//                         setState(() {
//                           selectedGender = value!;
//                         });
//                       },
//                     ),
//                     ColorChangingRadio(
//                       text: 'ชาย',
//                       value: 'Male',
//                       groupValue: selectedGender,
//                       onChanged: (String? value) {
//                         setState(() {
//                           selectedGender = value!;
//                         });
//                       },
//                     ),
//                     ColorChangingRadio(
//                       text: 'อื่น ๆ',
//                       value: 'Others',
//                       groupValue: selectedGender,
//                       onChanged: (String? value) {
//                         setState(() {
//                           selectedGender = value!;
//                         });
//                       },
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//             bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(bottom: 50, left: 27, right: 27),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const SizedBox(
//               height: 40,
//               width: 118,
//             ),
//             ForwardButton(
//               onPressed: () {
//                 // if (selectedGender.isNotEmpty) {
//                 //   sendUserDataToBackend(selectedGender);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const FirstLogin2()),
//                   );
//                 // } else {
//                 //   // Prompt user to select a gender or handle this case accordingly
//                 //   print("Please select a gender");
//                 // }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
