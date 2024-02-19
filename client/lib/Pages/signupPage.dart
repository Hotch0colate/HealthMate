// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously

import 'package:client/Pages/login.dart';
import 'package:client/services/auth_service.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController _usernameController = TextEditingController();
  bool _obscurePassword = true; // Flag to toggle password visibility

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
      Navigator.of(context).pop(); // Close the loading indicator
      Navigator.pushReplacementNamed(context,
          '/home'); // Navigate to home.dart or use your preferred method
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 93,
        backgroundColor: Colors.white,
        leading: Transform.translate(
          offset: const Offset(24, 16),
          child: GestureDetector(
            onTap: () {
              // Handle back button tap here
              Navigator.pop(context); // Navigate back to the previous screen
            },
            child: Image.asset(
              'lib/icons/back_new.png',
              height: 20,
              width: 20,
              color: Colors.grey,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 0),
                child: const Text(
                  'HEALTH',
                  style: TextStyle(
                    color: Color.fromRGBO(33, 150, 243, 1),
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 0),
                child: const Text(
                  'MATE',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 20,
          ),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'สวัสดีฮับป๋ม,',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Text(
                    'มาสร้างบัญชีกัน!',
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
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      controller: _usernameController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'ชื่อผู้ใช้',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: 24, right: 24),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
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
                                            _emailController, // Assigning the controller to the TextFormField
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'ใส่อีเมล',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 20,
                                          ),
                                          contentPadding: EdgeInsets.only(
                                              left: 24, right: 24),
                                        ),
                                      ),
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
                                padding: const EdgeInsets.only(top: 7),
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
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 25, bottom: 4),
                                      child: const Text(
                                        'ยืนยันรหัสผ่าน',
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
                                        obscureText: _obscurePassword,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'ยืนยันรหัสผ่าน',
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
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
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
                              const SizedBox(height: 19),
                              ElevatedButton(
                                onPressed:
                                    _signup, // Call the _signup method when the button is pressed
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(color: Colors.orange),
                                ),
                                child: const SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text(
                                      'สร้างบัญชี',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),
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
                                            builder: (context) =>
                                                const LoginPage()),
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
                              const SizedBox(height: 24),
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
