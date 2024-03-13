import 'dart:convert';

import 'package:client/Pages/emotion_calendar/calendar_table.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/services/ip_variable.dart';
import 'package:http/http.dart' as http;

import 'package:client/component/buttons.dart';
import 'package:client/component/calendar/emotion_scroll.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String currentSelectedEmotion = '';
TextEditingController descriptionController = TextEditingController();

Future<void> createEmotionAndSending(String? token, String description) async {
  try {
    final response = await http.post(
      Uri.parse('http://${fixedIp}:3000/emotion/create_data'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // ส่ง token ใน header
      },
      body: jsonEncode({
        "emotion": currentSelectedEmotion,
        "description": description, // Include the user's description
      }),
    );

    if (response.statusCode == 200) {
      print('Sending emotion to the database successfully');
    } else {
      print('Error while sending emotion: ${response.reasonPhrase}');
    }
  } catch (error) {
    print('Error while sending emotion: $error');
  }
}

void _sendingEmotionWithToken(BuildContext context, String description,
    VoidCallback refreshEmotionsCallback) async {
  // สมมติว่าคุณมีฟังก์ชัน `getToken` ที่สามารถดึง token ของผู้ใช้
  var _auth_service = AuthService();
  String? token = await _auth_service.getIdToken();
  await createEmotionAndSending(token, description);
  print(refreshEmotionsCallback);
  refreshEmotionsCallback();
}

void showCustomDialog(
    BuildContext context, VoidCallback refreshEmotionsCallback) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Align(
          alignment: Alignment.bottomCenter,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: dialogContent(context, (selectedEmotion) {
              currentSelectedEmotion = selectedEmotion;
            }, refreshEmotionsCallback),
          ));
    },
  );
}

Widget dialogContent(BuildContext context, Function(String) onEmotionSelected,
    VoidCallback refreshEmotionsCallback) {
  // Get the current date
  DateTime currentDate = DateTime.now();
  int buddhistEraYear = currentDate.year + 543;
  String formattedDate =
      '${DateFormat('d MMMM ', 'th').format(currentDate)}$buddhistEraYear';

  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: ColorTheme.WhiteColor,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'เลือกอารมณ์ของคุณ',
              style: FontTheme.subtitle2,
            ),
            IconButton(
              icon: const Icon(
                Icons.close,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        Text(
          formattedDate,
          style: FontTheme.subtitle1.copyWith(color: ColorTheme.primaryColor),
        ),
        EmotionScroll(onEmotionSelected: onEmotionSelected),
        TextField(
          controller: descriptionController,
          decoration: InputDecoration(
            hintText: 'รายละเอียดอารมณ์ของคุณ',
            hintStyle: FontTheme.body1,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SmPrimaryButton(
            text: 'บันทึก',
            onPressed: () {
              print(refreshEmotionsCallback);
              _sendingEmotionWithToken(context, descriptionController.text, () {
                refreshEmotionsCallback();
              });
              descriptionController.clear();
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    ),
  );
}
