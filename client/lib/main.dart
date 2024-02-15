// import 'package:client/Pages/chatPage.dart';
import 'package:flutter/material.dart';

import 'Pages/signupPage.dart';
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
      home: SignupPage(),
      routes: {
        '/login': (context) => SignupPage(),
        '/signup': (context) => SignupPage(),
        '/main': (context) => MainApp(),
      },
    );
  }
}
