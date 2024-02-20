// import 'package:client/Pages/chatPage.dart';
import 'package:client/Pages/First%20Login/first_login1.dart';
import 'package:client/Pages/login.dart';
import 'package:flutter/material.dart';

import 'Pages/signupPage.dart';
import 'Pages/home.dart';
import 'component/navigation.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

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
      home: const SignupPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/main': (context) => MainApp(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
