// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously, file_names

import 'package:client/component/text_field/text_field.dart';
import 'package:client/pages/authentication/login.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

import 'package:client/component/text_field/grey_text_field.dart';
import 'package:client/component/buttons.dart';
import 'package:client/component/text_field/password_field.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthMate',
      home: SignupPage(),
    );
  }
}

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
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 50,
          ),
          child: Column(
            children: [
              Image.asset('assets/logos/medium_app_name.png'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('สวัสดีฮับป๋ม,', style: FontTheme.subtitle1),
                  const Text('มาสร้างบัญชีกัน!', style: FontTheme.subtitle2),
                  Container(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
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
                                        InputTextField(
                                          controller: _usernameController,
                                          hintText: 'กรอกชื่อผู้ใช้',
                                          labelText: 'ชื่อผู้ใช้',
                                        ),
                                        SizedBox(height: 5),
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
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LoginPage()),
                                                  );
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
                                              child: Text(' เข้าสู่ระบบที่นี่',
                                                  style: FontTheme.body1
                                                      .copyWith(
                                                          color: ColorTheme
                                                              .primaryColor)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
