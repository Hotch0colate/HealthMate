// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'package:client/component/buttons.dart';
import 'package:client/pages/profile/edit_profile.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/services/ip_variable.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:http/http.dart' as http;

//page import
import '../authentication/login.dart';

String userName = '';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    // Call the function to fetch the username when the widget is initialized
    readUserName();
  }

  Future<void> readUserName() async {
    try {
      var _auth_service = AuthService();
      String? token = await _auth_service.getIdToken();

      final response = await http.get(
        Uri.parse('http://${fixedIp}:3000/user/read_data'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(token);

      if (response.statusCode == 200) {
        dynamic responseData = json.decode(response.body);
        print(responseData['Data']);
        if (responseData != null && responseData is Map<String, dynamic>) {
          Map<String, dynamic> data = json.decode(response.body)['Data'];
          setState(() {
            userName = data['username'];
          });
        } else {
          throw Exception('Invalid snapshot value or format');
        }
      } else {
        throw Exception('Failed to load username: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load username: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userName,
              style: FontTheme.h4.copyWith(color: ColorTheme.primaryColor),
            ),
          ],
        ),
      ),
      backgroundColor: ColorTheme.WhiteColor,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        // Wrap with SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     IconButton(
                    //       icon: const Icon(
                    //         Icons
                    //             .arrow_back_ios, // Replace with your custom icon
                    //         color: Colors.black38,
                    //         size: 30, // Customize the icon color
                    //       ),
                    //       onPressed: () {
                    //         Navigator.pop(context);
                    //       },
                    //     ),
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     // Image.asset(
                    //     //   'assets/avatar/md_10.png',
                    //     //   width: 80,
                    //     // ),
                    //     // Column(
                    //     //   crossAxisAlignment: CrossAxisAlignment.start,
                    //     //   children: [
                    //     //     Text(
                    //     //       userName, // Use the updated userName here
                    //     //       style: FontTheme.subtitle1.copyWith(
                    //     //         color: ColorTheme.primaryColor,
                    //     //       ),
                    //     //     ),
                    //     //   ],
                    //     // ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 12,
                    ),
                    CustomElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfilePage()),
                        );
                      },
                      leadingIcon: CupertinoIcons.person_fill,
                      text: 'แก้ไขโปรไฟล์',
                      trailingIcon: CupertinoIcons.forward,
                      backgroundColor: Colors.black12,
                      iconColor: ColorTheme.baseColor,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    CustomElevatedButton(
                      onPressed: () {
                        print('Container tapped!');
                      },
                      leadingIcon: CupertinoIcons.bell_fill,
                      text: 'การแจ้งเตือน',
                      trailingIcon: CupertinoIcons.forward,
                      backgroundColor: Colors.black12,
                      iconColor: ColorTheme.baseColor,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    CustomElevatedButton(
                      onPressed: () {
                        print('Container tapped!');
                      },
                      leadingIcon: CupertinoIcons.gear_alt_fill,
                      text: 'บัญชีและความเป็นส่วนตัว',
                      trailingIcon: CupertinoIcons.forward,
                      backgroundColor: Colors.black12,
                      iconColor: ColorTheme.baseColor,
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 50,
                      thickness: 1,
                    ),
                    SpecialButton(
                      buttonText: 'ออกจากระบบ',
                      onPressed: () {
                        _logout(context);
                      },
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

void _logout(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
    //   (Route<dynamic> route) => false,
    // );

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text("Logged out successfully"),
    //   ),
    // );
    AuthService().removeToken();
    print("Logged out successfully");
  } catch (e) {
    print(e); // Add this line to print the error to the console
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error logging out: $e"),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData leadingIcon;
  final String text;
  final IconData trailingIcon;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;

  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.leadingIcon,
    required this.text,
    required this.trailingIcon,
    this.backgroundColor = Colors.black12,
    this.iconColor = ColorTheme.baseColor,
    this.iconSize = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(8.0), // Adjust border radius as needed
        ),
        elevation: 0,
        backgroundColor: backgroundColor, // Adjust elevation as needed
      ),
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              leadingIcon,
              color: iconColor,
              size: iconSize,
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              text,
              style: FontTheme.body1.copyWith(
                  color: ColorTheme.baseColor), // Adjust font size as needed
            ),
            Spacer(),
            Icon(
              trailingIcon,
              color: iconColor,
              size: iconSize,
            ),
          ],
        ),
      ),
    );
  }
}
