// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, avoid_print
import 'package:client/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//page import
import 'package:client/pages/authentication/signup.dart';

//component import
import '../../component/text_field/grey_text_field.dart';
import '../../component/buttons.dart';

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
      await AuthService().sendTokenToBackend(idToken);

      // Assuming token verification was successful, navigate to home.dart
      Navigator.of(context).pop(); // Close the loading indicator
      Navigator.pushReplacementNamed(context,
          '/main'); // Navigate to home.dart or use your preferred method
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Image.asset('assets/logos/medium_app_name.png')),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 24),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ยินดีต้อนรับค้าบบ,',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Text(
                    'เข้าสู่ระบบกัน!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 15),
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
                                        hintText: 'ใส่อีเมล'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 25, bottom: 4),
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
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        color: Color(0x22212133),
                                      ),
                                      child: TextFormField(
                                        controller:
                                            _passwordController, // Assigning the controller to the TextFormField
                                        obscureText: _obscurePassword,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'ใส่รหัสผ่าน',
                                          hintStyle: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 20,
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                            left: 24,
                                            right: 24,
                                            top:
                                                14, // Adjust top padding as needed
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
                              const SizedBox(height: 5),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'ลืมรหัสผ่าน?',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFB95000),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              OrangeButton(
                                onPressed: _login,
                                buttonText: 'เข้าสู่ระบบ',
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'เพิ่งเคยเข้ามาใน',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Text(' Health',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      )),
                                  const Text(
                                    'Mate ',
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const Text(
                                    'ใช่หรือไม่',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                    ),
                                  ),
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
                                    child: const Text(
                                      'สมัครใหม่',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.orange,
                                      ),
                                    ),
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
                                const Text(
                                  'เข้าสู่ระบบด้วย',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ]),
                              const SizedBox(height: 19),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  LoginWithButton(
                                      imagePath: 'assets/icons/google.png'),
                                  SizedBox(width: 16),
                                  LoginWithButton(imagePath: 'assets/icons/apple.png'),
                                  SizedBox(width: 24),
                                  LoginWithButton(
                                      imagePath: 'assets/icons/facebook.png'),
                                ],
                              ),
                              const SizedBox(height: 41),
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
                                            color:
                                                Colors.orange, // Set to orange
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' และ ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black, // Set to black
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'นโยบายความเป็นส่วนตัว',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color:
                                                Colors.orange, // Set to orange
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
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
