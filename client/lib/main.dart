import 'package:client/pages/authentication/first_login/first_login_2.dart';
import 'package:client/pages/authentication/first_login/first_login_3.dart';
import 'package:client/pages/authentication/first_login/first_login_4.dart';
import 'package:client/pages/authentication/first_login/first_login_5.dart';
import 'package:client/pages/select_talk/create_tag_page_volunteer.dart';
import 'package:client/pages/select_talk/find_volunteer_page.dart';

import 'package:client/pages/select_talk/select_talk_page.dart';
import 'package:client/pages/volunteer_register/volunteer_congrats.dart';
import 'package:client/pages/volunteer_register/volunteer_register.dart';
import 'package:client/pages/volunteer_register/volunteer_test_1.dart';
import 'package:client/pages/volunteer_register/volunteer_test_2.dart';
import 'package:client/pages/volunteer_register/volunteer_test_waiting.dart';
import 'package:client/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:client/services/notification.dart';

//page import
import 'pages/authentication/login.dart';
import 'pages/authentication/signup.dart';
import 'pages/splash_screen/splash_screen.dart';
import 'component/navigation.dart';
import 'pages/home.dart';
import 'pages/authentication/first_login/first_login_1.dart';

// test branch talk_gunn
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().initNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(     
         backgroundColor: ColorTheme.WhiteColor,
         ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/first_login': (context) => FirstLogin1(),
        '/first_login_2': (context) => FirstLogin2(),
        '/first_login_3': (context) => FirstLogin3(),
        '/first_login_4': (context) => FirstLogin4(),
        '/first_login_5': (context) => FirstLogin5(),
        '/main': (context) => MainApp(SelectedPage: 0),
        '/home': (context) => const HomePage(),
        // '/create_tag_page': (context) => const CreateTagPage(),
        // '/find_volunteer_page': (context) => const FindVolunteerPage(),
      },
    );
  }
}
