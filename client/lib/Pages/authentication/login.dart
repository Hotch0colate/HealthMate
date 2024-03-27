// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:client/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
//page import
import 'package:client/pages/authentication/signup.dart';

//component import
import 'package:client/component/buttons.dart';
import 'package:client/component/text_field/text_field.dart';
import 'package:client/component/text_field/grey_text_field.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true; // Flag to toggle password visibility

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    try {
      print('Login button pressed');
      print('_emailController.text: ${_emailController.text}');
      print('_passwordController.text: ${_passwordController.text}');
      // Perform Firebase login
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      User? user = userCredential.user;

      // Get ID Token from Firebase
      String? idToken = await user?.getIdToken();
      print('line 47....');
      print('idToken: $idToken');
      // Send the ID token to your backend for verification
      final response = await AuthService().sendTokenToBackend(idToken);

      AuthService().saveToken(idToken.toString());

      // // Assuming token verification was successful, navigate to home.dart
      // Navigator.of(context).pop(); // Close the loading indicator
      // Navigator.pushReplacementNamed(context,
      //     '/main'); // Navigate to home.dart or use your preferred method
// Correct usage as a standalone statement
      Navigator.pushReplacementNamed(context, '/main');

// Incorrect usage as part of an expression that expects a value
      var result = Navigator.pushReplacementNamed(
          context, '/main'); // This will give an error
    } catch (e) {
      print('Error occurred during login: $e');
      Navigator.of(context).pop(); // Close the loading indicator
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Error'),
            content: Text(
                'An error occurred during login. Please try again later. Error: $e'),
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

  Future<void> _loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the Google user credentials
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          // Successful login with Google, proceed to your app
          Navigator.pushReplacementNamed(context, '/main');
        }
      }
    } catch (e) {
      print('Error during Google login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.04),
          child: Image.asset('assets/logos/medium_app_name.png'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: screenHeight * 0.04,
            right: screenHeight * 0.04,
            top: screenHeight * 0.03,
            bottom: screenHeight * 0.03,
          ),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/logos/medium_app_name.png'),
                  Text('ยินดีต้อนรับค้าบบ,', style: FontTheme.subtitle1),
                  const Text('เข้าสู่ระบบกัน!', style: FontTheme.subtitle2),
                  Container(
                    padding: EdgeInsets.only(top: screenHeight * 0.015),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: screenHeight * 0.008,
                                bottom: screenHeight * 0.008,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: screenHeight * 0.025,
                                      bottom: screenHeight * 0.004,
                                    ),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.008),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: screenHeight * 0.025,
                                      bottom: screenHeight * 0.004,
                                    ),
                                    child: const Text(
                                      'รหัสผ่าน',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: screenHeight * 0.06,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(screenHeight * 0.015),
                                      ),
                                      color: const Color(0x22212133),
                                    ),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: _obscurePassword,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'ใส่รหัสผ่าน',
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,
                                        ),
                                        contentPadding: EdgeInsets.only(
                                          left: screenHeight * 0.024,
                                          right: screenHeight * 0.024,
                                          top: screenHeight * 0.014,
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _obscurePassword =
                                                  !_obscurePassword;
                                            });
                                          },
                                          child: Icon(
                                            _obscurePassword
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'ลืมรหัสผ่าน?',
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.014,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFFB95000),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            LgPrimaryButton(
                              onPressed: _login,
                              text: 'เข้าสู่ระบบ',
                            ),
                            SizedBox(height: screenHeight * 0.016),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'เพิ่งเคยเข้ามาใน',
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.016,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  ' Health',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: screenHeight * 0.016,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  'Mate ',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: screenHeight * 0.016,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  'ใช่หรือไม่',
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.016,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: screenHeight * 0.003),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'สมัครใหม่',
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.016,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.036,
                            ),
                            Row(children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: screenHeight * 0.008),
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'เข้าสู่ระบบด้วย',
                                style: TextStyle(
                                  fontSize: screenHeight * 0.02,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: screenHeight * 0.008),
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              ),
                            ]),
                            SizedBox(height: screenHeight * 0.019),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LoginWithButton(
                                  imagePath: 'assets/icons/google.png',
                                  onPressed: _loginWithGoogle,
                                ),
                                SizedBox(width: screenHeight * 0.016),
                                LoginWithButton(
                                  imagePath: 'assets/icons/apple.png',
                                  onPressed: () {},
                                ),
                                SizedBox(width: screenHeight * 0.024),
                                LoginWithButton(
                                    imagePath: 'assets/icons/facebook.png',
                                    onPressed: () {}),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.041),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'การเข้าสู่ระบบหรือสร้างบัญชีแสดงว่าคุณยอมรับ',
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.014,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'ข้อกำหนดและเงื่อนไข',
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.014,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' และ ',
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.014,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'นโยบายความเป็นส่วนตัว',
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.014,
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
