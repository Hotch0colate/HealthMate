import 'dart:convert';

import 'package:client/services/auth_service.dart';
import 'package:client/services/ip_variable.dart';
import 'package:http/http.dart' as http;

import 'package:client/models/emotion_model.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:client/component/calendar/emotion_card.dart';

class EmotionDetailPage extends StatefulWidget {
  final DateTime date;
  VoidCallback refreshEmotionCalendarCallback;

  EmotionDetailPage(
      {Key? key,
      required this.date,
      required this.refreshEmotionCalendarCallback})
      : super(key: key);

  @override
  _EmotionDetailPageState createState() => _EmotionDetailPageState();
}

class _EmotionDetailPageState extends State<EmotionDetailPage> {
  List<Emotions> unformattedEmotion = [];
  bool deleteLastOneClose = false;

  @override
  void initState() {
    super.initState();
    _recieveDetailDayEmotionWithToken();
    deleteLastOneClose = false;
  }

  void _recieveDetailDayEmotionWithToken() async {
    // สมมติว่าคุณมีฟังก์ชัน `getToken` ที่สามารถดึง token ของผู้ใช้
    var _auth_service = AuthService();
    String? token = await _auth_service.getIdToken();
    await recievedDetailDayEmotion(token);
  }

  Future<void> recievedDetailDayEmotion(String? token) async {
    try {
      String stringMonth = widget.date.month.toString();
      String stringDay = widget.date.day.toString();
      String stringYear = (widget.date.year + 543).toString();

      final response = await http.post(
        Uri.parse('http://${fixedIp}:3000/emotion/read_data'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Send token in the header
        },
        body: jsonEncode(
            {"dayMonthYear": "${stringDay}-${stringMonth}-${stringYear}"}),
      );

      if (response.statusCode == 200) {
        // print('Received each emotion of the day successfully');
        final data = json.decode(response.body)['Data'];

        // Check if data is not null before proceeding
        if (data != null) {
          final emotionData = Map<String, dynamic>.from(data);

          // Clear the list before adding new items to avoid duplicating the previous state's data
          unformattedEmotion.clear();

          emotionData.forEach((key, value) {
            // Ensure that the required fields are not null before proceeding
            if (value != null &&
                value['time'] != null &&
                value['emotion'] != null &&
                value['description'] != null &&
                value['eid'] != null) {
              DateTime parsedDate = DateFormat("d/M/yyyy HH:mm:ss", 'th')
                  .parse(value['time'], true);
              parsedDate = DateTime(
                  parsedDate.year - 543, // Adjust year for Buddhist calendar
                  parsedDate.month,
                  parsedDate.day,
                  parsedDate.hour, // Preserve the hour
                  parsedDate.minute, // Preserve the minutes
                  parsedDate.second // Preserve the seconds
                  );

              unformattedEmotion.add(Emotions(
                  dateTime: parsedDate,
                  emotion: value['emotion'],
                  detail: value['description'],
                  eid: value['eid']));
            }
          });

          if (unformattedEmotion.length >= 1) {
            deleteLastOneClose = true;
          }

          setState(() {}); // Trigger a state update to refresh the UI
        } else {
          if (deleteLastOneClose) {
            Navigator.pop(context);
          }
        }
      } else {
        print('Error receiving: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error receiving: $error');
    }
  }

  void refreshEmotionsCallback() {
    // Access the stateful widget and call the refresh function
    _recieveDetailDayEmotionWithToken();
    widget.refreshEmotionCalendarCallback();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('th', null);

    // Calculate the Thai (Buddhist) year and Gregorian year
    int thaiYear = widget.date.year + 543;

    String formattedDateThai =
        '${DateFormat('d MMMM ', 'th').format(widget.date)}$thaiYear';

    List<Emotions> formattedEmotion = unformattedEmotion.where((emotion) {
      final emotionDate = DateTime(
          emotion.dateTime.year, emotion.dateTime.month, emotion.dateTime.day);
      final widgetDate =
          DateTime(widget.date.year, widget.date.month, widget.date.day);
      return emotionDate.isAtSameMomentAs(widgetDate);
    }).toList();

    formattedEmotion.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios, // Replace with your custom icon
            color: ColorTheme.baseColor,
            size: 30, // Customize the icon color
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: ColorTheme.WhiteColor,
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  formattedDateThai,
                  style: FontTheme.h3.copyWith(color: ColorTheme.primaryColor),
                ),
              ],
            ),
          ),
          // set to start left 
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: formattedEmotion.map((emotion) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: EmotionCard(
                        emotions: emotion,
                        refreshEmotionsCallback: refreshEmotionsCallback),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
