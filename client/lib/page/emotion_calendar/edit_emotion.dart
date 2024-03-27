import 'dart:convert';

import 'package:client/services/auth_service.dart';
import 'package:client/services/ip_variable.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:client/component/buttons.dart';
import 'package:client/component/text_field/grey_text_field.dart';
import 'package:client/models/emotion_model.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';

class EmotionDetailsDialog {
  static void show(BuildContext context, Emotions emotions,
      VoidCallback refreshEmotionsCallback) {
    TextEditingController _controller =
        TextEditingController(text: emotions.detail);

    // print(emotions.eid);

    Future<void> deleteEmotion(String? token) async {
      try {
        String formattedDate = formatToBuddhistYear(emotions.dateTime);

        final response = await http.post(
          Uri.parse('http://${fixedIp}:3000/emotion/delete_data'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token', // Send token in the header
          },
          body: jsonEncode(
              {"date": "${formattedDate}", "eid": "${emotions.eid}"}),
        );

        if (response.statusCode != 200) {
          print('Error receiving: ${response.reasonPhrase}');
        }
      } catch (error) {
        print('Error receiving: $error');
      }
    }

    void _deleteEmotionWithToken(
        BuildContext context, VoidCallback refreshEmotionsCallback) async {
      // สมมติว่าคุณมีฟังก์ชัน `getToken` ที่สามารถดึง token ของผู้ใช้
      var _auth_service = AuthService();
      String? token = await _auth_service.getIdToken();
      await deleteEmotion(token);
      // print(refreshEmotionsCallback);
      refreshEmotionsCallback();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 66.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat('HH:mm').format(emotions.dateTime),
                          style: FontTheme.subtitle1,
                        ),
                        SizedBox(
                          width: 60,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/emotion/emotion_text/m_${emotions.emotion}_t.png',
                      height: 120,
                      width: 120,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GreyTextField(controller: _controller, hintText: ''),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SmPrimaryButton(text: 'บันทึก', onPressed: () {}),
                        SmSecondaryButton(
                          text: 'ลบ',
                          onPressed: () {
                            _deleteEmotionWithToken(context, () {
                              refreshEmotionsCallback();
                            });
                            Navigator.of(context).pop();
                          },
                          foregroundColor: ColorTheme.errorAction,
                          backgroundColor: ColorTheme.WhiteColor,
                          borderColor: ColorTheme.errorAction,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static String _formatThaiYear(DateTime dateTime) {
    final thaiYear = dateTime.year + 543;
    final thaiDate = DateTime(thaiYear, dateTime.month, dateTime.day,
        dateTime.hour, dateTime.minute, dateTime.second);
    return DateFormat('dd MMMM yyyy', 'th_TH').format(thaiDate);
  }

  static String formatToBuddhistYear(DateTime dateTime) {
    final buddhistYear = dateTime.year + 543;
    final dateWithBuddhistYear =
        DateTime(buddhistYear, dateTime.month, dateTime.day);
    return DateFormat('dd-MM-yyyy').format(dateWithBuddhistYear);
  }
}
