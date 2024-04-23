// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously, file_names

import 'package:client/component/text_field/text_field.dart';
import 'package:client/pages/authentication/login.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/services/ip_variable.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:client/component/buttons.dart';

// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _usernameController =
      TextEditingController(); // Flag to toggle password visibility

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signup() async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print('_usernameController.text: ${_usernameController.text}');
      User? user = userCredential.user;
      await user?.updateDisplayName(_usernameController.text);
      await user?.reload();

      User? latestUser = FirebaseAuth.instance.currentUser;
      print('username: ${latestUser?.displayName}');
      print('latestUser: $latestUser');

      final DatabaseReference dbRef =
          FirebaseDatabase.instance.ref("users/${latestUser?.uid}");
      await dbRef.set({
        "username": _usernameController.text,
        "email": _emailController.text,
      });

      // Get the ID token of the newly signed-up user
      String? idToken = await latestUser?.getIdToken();

      // Send the ID token to your backend for verification
      await AuthService().sendTokenToBackend(idToken);
      print('line 61');
      // Assuming token verification was successful, navigate to home.dart
      // Note: In a real app, you'd handle the response from your backend to confirm token verification was successful
      AuthService().saveToken(idToken.toString());
      Navigator.of(context).pop(); // Close the loading indicator

      final response = await http.post(
        Uri.parse('http://${fixedIp}:3000/user/save_state_first_login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken', // ส่ง token ใน header
        },
        body: jsonEncode({"firstloginstage": 1}),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context,
            '/first_login'); // Navigate to home.dart or use your preferred method
      } else {
        Navigator.of(context).pop();
      }
    } catch (e) {
      print('Signup failed: $e');
      Navigator.of(context).pop(); // Close the loading indicator

      // Show an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Signup Error'),
            content: Text(
                'An error occurred during signup. Please try again later. Error: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorTheme.WhiteColor,
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 50,
                ),
                child: Column(children: [
                  Image.asset('assets/logos/medium_app_name.png'),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('สวัสดีฮับป๋ม,', style: FontTheme.subtitle1),
                        const Text('มาสร้างบัญชีกัน!',
                            style: FontTheme.subtitle2),
                        Container(
                          padding: const EdgeInsets.only(top: 15),
                          child: Column(children: [
                            Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //ลบตรงนี้จ้าาา ><
                                          InputTextField(
                                            controller: _usernameController,
                                            hintText: 'กรอกชื่อผู้ใช้',
                                            labelText: 'ชื่อผู้ใช้',
                                          ),
                                          SizedBox(height: 5),
                                          //ถึงตรงนี้จ้าาา ><
                                          InputTextField(
                                            controller: _emailController,
                                            hintText: 'กรอกอีเมล',
                                            labelText: 'อีเมล',
                                          ),
                                          SizedBox(height: 5),
                                          NormalPasswordTextField(
                                            controller: _passwordController,
                                          ),
                                          SizedBox(height: 5),
                                          ConfirmPasswordTextField(
                                            controller:
                                                _confirmPasswordController,
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SpecialButton(
                                                  onPressed: () {
                                                    _signup();
                                                  },
                                                  buttonText: 'สร้างบัญชี')
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('มับัญชีอยู่แล้วใช่หรือไม่?',
                                                  style: FontTheme.body2),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LoginPage()),
                                                  );
                                                },
                                                // Set the color when hover
                                                child: Text(
                                                    ' เข้าสู่ระบบที่นี่',
                                                    style: FontTheme.body1
                                                        .copyWith(
                                                            color: ColorTheme
                                                                .primaryColor)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: screenHeight * 0.02)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ])
                ]))));
  }
}
