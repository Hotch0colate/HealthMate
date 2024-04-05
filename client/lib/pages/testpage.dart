// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously, file_names

import 'package:client/component/select_box.dart';
import 'package:client/component/selected_card.dart';
import 'package:client/pages/authentication/first_login/first_login_2.dart';
import 'package:client/pages/emotion_calendar/calendar.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

import 'package:client/component/buttons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthMate',
      home: FirstLogin1(),
    );
  }
}

class FirstLogin1 extends StatefulWidget {
  const FirstLogin1({Key? key}) : super(key: key);

  @override
  _FirstLogin3State createState() => _FirstLogin3State();
}

class _FirstLogin3State extends State<FirstLogin1> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons
                                  .arrow_back_ios, // Replace with your custom icon
                              color: Colors.black38,
                              size: 30, // Customize the icon color
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/images/psychiatrist_tool_glasses.png',
                        width: 100,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          SelectableCard(
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                isSelected = !isSelected;
                              });
                            },
                            child: Text(
                              'ภาระหน้าที่',
                              style: FontTheme.body1.copyWith(
                                fontSize: 20.0,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            borderColor: Colors.grey,
                          ),
                          SizedBox(width: 16,),
                           SelectableCard(
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                isSelected = !isSelected;
                              });
                            },
                            child: Text(
                              'ความสัมพันธ์',
                              style: FontTheme.body1.copyWith(
                                fontSize: 20.0,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            borderColor: Colors.grey,
                          ),
                        ],
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
