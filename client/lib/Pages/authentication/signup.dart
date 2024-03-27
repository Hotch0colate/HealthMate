// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously, file_names

import 'package:client/component/text_field/text_field.dart';
import 'package:client/pages/authentication/login.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

import 'package:client/component/text_field/grey_text_field.dart';
import 'package:client/component/buttons.dart';
import 'package:client/component/text_field/password_field.dart';
import 'package:client/component/text_field/white_text_field.dart';

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
      Navigator.pushReplacementNamed(context,
          '/first_login'); // Navigate to home.dart or use your preferred method
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
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1,
        backgroundColor: Colors.white,
        leading: Transform.translate(
          offset: const Offset(24, 16),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Image(
              image: AssetImage('assets/icons/back_new.png'),
              height: 20,
              width: 20,
              color: Colors.grey,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.04),
          child: Image.asset('assets/logos/medium_app_name.png'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenHeight * 0.02,
            vertical: screenHeight * 0.01,
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
                    padding: EdgeInsets.only(top: screenHeight * 0.015),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: const Text(
                                    'ชื่อผู้ใช้',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                GreyTextField(
                                  controller: _usernameController,
                                  hintText: 'ใส่ชื่อผู้ใช้',
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.007),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, bottom: 4),
                                    child: const Text(
                                      'อีเมล',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  GreyTextField(
                                    controller: _emailController,
                                    hintText: 'ใส่อีเมล',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.007),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 25, bottom: 4),
                                child: const Text(
                                  'รหัสผ่าน',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              PasswordTextField(
                                controller: _passwordController,
                                hintText: 'ใส่รหัสผ่าน',
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.007),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 25, bottom: 4),
                                child: const Text(
                                  'ยืนยันรหัสผ่าน',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              PasswordTextField(
                                controller: _confirmPasswordController,
                                hintText: 'ยืนยันรหัสผ่าน',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        OrangeButton(
                          onPressed: _signup,
                          buttonText: 'สร้างบัญชี',
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'มีบัญชีอยู่แล้วใช่หรือไม่?',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 3),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                ' เข้าสู่ระบบที่นี่',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'การเข้าสู่ระบบหรือสร้างบัญชีแสดงว่าคุณยอมรับ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'ข้อกำหนดและเงื่อนไข',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' และ ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'นโยบายความเป็นส่วนตัว',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
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
        ),
      ),
    );
  }
}
