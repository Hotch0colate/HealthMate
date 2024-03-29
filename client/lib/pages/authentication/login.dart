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


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthMate',
      home: LoginPage(),
    );
  }
}
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
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
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InputTextField(
                                      controller: _emailController,
                                      hintText: 'ใส่อีเมล',
                                      labelText: 'อีเมล',
                                    ),
                                    SizedBox(height: 10),
                                    PasswordInputTextField(
                                      controller: _passwordController,
                                      hintText: 'ใส่รหัสผ่าน',
                                      labelText: 'รหัสผ่าน',
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'ลืมรหัสผ่าน?',
                                    style: FontTheme.caption.copyWith(
                                        color: ColorTheme.warningAction),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SpecialButton(
                                      onPressed: _login,
                                      buttonText: 'เข้าสู่ระบบ')
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('เข้า', style: FontTheme.body2),
                                  Text(' Health',
                                      style: FontTheme.body2.copyWith(
                                          color: ColorTheme.primaryColor)),
                                  Text('Mate ',
                                      style: FontTheme.body2.copyWith(
                                          color: ColorTheme.secondaryColor)),
                                  Text('ครั้งแรกใช่ไหม?',
                                      style: FontTheme.body2),
                                  const SizedBox(width: 3),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignupPage()),
                                      );
                                    },
                                    // Set the color when hover
                                    child: Text('สมัครใหม่',
                                        style: FontTheme.body1.copyWith(
                                            color: ColorTheme.primaryColor)),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 36,
                              ),
                              Row(children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              Text(
                                'เข้าสู่ระบบด้วย',
                                style: FontTheme.body1
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
                                // LoginWithButton(
                                //   imagePath: 'assets/icons/google.png',
                                //   onPressed: _loginWithGoogle,
                                // ),
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
