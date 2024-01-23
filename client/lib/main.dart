import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// ignore: unused_import
import 'Pages/pages.dart';
// import 'components/chatAppbar.dart';
import 'Pages/login.dart';
import 'Pages/signupPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignupPage(),
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
        });
  }
}
