import 'package:client/component/select_box.dart';
import 'package:client/component/text_field/text_field.dart';
import 'package:client/services/ip_variable.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:client/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//page import
import 'package:client/pages/authentication/first_login/first_login_2.dart';

//component import
import '../../../component/buttons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthMate',
      home: FirstLogin0(),
    );
  }
}

class FirstLogin0 extends StatefulWidget {
  FirstLogin0({Key? key}) : super(key: key);


  @override
  _FirstLogin0State createState() => _FirstLogin0State();
}

class _FirstLogin0State extends State<FirstLogin0> {
  bool agreedToTerms = false;
  
  TextEditingController UsernameTextController = TextEditingController();

  // Function to submit the gender to the backend
  // Future<void> sendUserDataToBackend(String gender) async {
  //   var _auth_service = AuthService();
  //   String? token = await _auth_service.getIdToken();
  //   var url = Uri.parse(
  //       'http://${fixedIp}:3000/user/update_data'); // Change to your actual endpoint
  //   var response = await http.post(url,
  //       body: json.encode({'gender': gender}),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token'
  //       });

  //   if (response.statusCode == 200) {
  //     // Handle successful request
  //     print("Gender submitted successfully");
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const FirstLogin2(),
  //       ),
  //     );
  //   } else {
  //     // Handle error
  //     print("Failed to submit gender: ${response.body}");
  //   }
  // }

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
                width: MediaQuery.of(context).size.width - 32,
              ),
              Image.asset('assets/logos/big_app_name.png'),
              const SizedBox(height: 24),
              const SizedBox(
                height: 72,
                child: Image(
                  image: AssetImage('assets/logos/main_mascot.png'),
                ),
              ),
              const SizedBox(height: 18),
              Text('มาตั้ง"ชื่อผู้ใช้"ของคุุณกันน!',
                  style: FontTheme.subtitle1
                      .copyWith(color: ColorTheme.primaryColor)),
              const SizedBox(height: 24),
              Text('คำตอบของคุณ: ', style: FontTheme.body1),
              const SizedBox(height: 12),
              InputTextField(
                controller: UsernameTextController, hintText: 'ชื่อผู้ใช้', showLabel: false,)
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
                // if (selectedGender.isNotEmpty) {
                //   sendUserDataToBackend(selectedGender);
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const FirstLogin2()),
                //   );
                // } else {
                //   // Prompt user to select a gender or handle this case accordingly
                //   print("Please select a gender");
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}
