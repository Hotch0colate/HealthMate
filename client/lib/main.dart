// import 'package:client/Pages/chatPage.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// ignore: unused_import
import 'Pages/pages.dart';
// import 'components/chatAppbar.dart';
import 'Pages/login.dart';
import 'Pages/signupPage.dart';
import 'component/navigation.dart';
import 'Pages/chatroom.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ChatRoom(
          cid: "b4KPDSh8oY69A6mQGn4I",
          uid: "pTw4p0fFpvRQAGlabQhHB47yUQr2",
          messages: [],
        ),
        routes: {
          '/login': (context) => const LoginPage(),
          '/signup': (context) => SignupPage(),
          '/main': (context) => MainApp()
        });
  }
}
