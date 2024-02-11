import 'package:client/Pages/First%20Login/first_login1.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'Pages/pages.dart';
import 'Pages/login.dart';
import 'Pages/signupPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        '/login': (context) => SignupPage(),
        '/signup': (context) => SignupPage(),
      },
    );
  }
}
