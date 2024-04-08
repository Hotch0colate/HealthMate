import 'dart:convert';
import 'package:client/component/selected_card.dart';
import 'package:client/theme/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedCardIndex = -1; // -1 indicates no card selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Cards Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SelectedCard(
                  text: 'ทั่วไป',
                  icon: Icons.emoji_emotions,
                  onPressed: () {
                    setState(() {
                      selectedCardIndex = 0;
                    });
                  },
                  isSelected: selectedCardIndex == 0,
                ),
                SelectedCard(
                  text: 'ภาระหน้าที่',
                  icon: Icons.work,
                  onPressed: () {
                    setState(() {
                      selectedCardIndex = 1;
                    });
                  },
                  isSelected: selectedCardIndex == 1,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SelectedCard(
                  text: 'ความสัมพันธ์',
                  icon: CupertinoIcons.person_3_fill,
                  onPressed: () {
                    setState(() {
                      selectedCardIndex = 2;
                    });
                  },
                  isSelected: selectedCardIndex == 2,
                ),
                SelectedCard(
                  text: 'สุขภาพ',
                  icon: CupertinoIcons.heart_fill,
                  onPressed: () {
                    setState(() {
                      selectedCardIndex = 3;
                    });
                  },
                  isSelected: selectedCardIndex == 3,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
