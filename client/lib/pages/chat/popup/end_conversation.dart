import 'package:client/component/buttons.dart';
import 'package:client/component/calendar/emotion_scroll.dart';
import 'package:client/component/navigation.dart';
import 'package:client/pages/chat/popup/rating.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/services/ip_variable.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

void showEndcConvarsationDialog(BuildContext context, String cid) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: dialogContent(context, cid),
        ),
      );
    },
  );
}

Widget dialogContent(BuildContext context, String cid) {
  Future<void> completeChat(String _cid) async {
    var _auth_service = AuthService();
    String? token = await _auth_service.getIdToken();
    try {
      final response = await http.post(
        Uri.parse('http://${fixedIp}:3000/chatlog/update_data'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({
          'cid': _cid,
          'complete': true,
        }),
      );

      if (response.statusCode == 200) {
        print('Message sent successfully');
      } else {
        print('Error sending message: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error sending message: $error');
    }
  }

  return Container(
    padding: EdgeInsets.all(16.0),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'ต้องการจบการสนทนาหรือไม่',
              style: FontTheme.body1,
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmPrimaryButton(
              text: 'ยืนยัน',
              onPressed: () {
                completeChat(cid);
                Navigator.popUntil(context, (route) {
                  // print(route.settings.name);
                  if (route.settings.name == '/main') {
                    // print(route.settings.name);
                    final state = mainAppKey.currentState;
                    if (state != null) {
                      // print(state);
                      state.goToChatLog();
                    }
                    // print('on back press return true');
                    return true;
                  }
                  // print('on back press return false');
                  return false;
                });
              },
              backgroundColor: ColorTheme.successAction,
              borderColor: ColorTheme.successAction,
            ),
            SmPrimaryButton(
              text: 'ยกเลิก',
              onPressed: () {
                Navigator.of(context).pop();
              },
              backgroundColor: ColorTheme.errorAction,
              borderColor: ColorTheme.errorAction,
            ),
          ],
        ),
      ],
    ),
  );
}
