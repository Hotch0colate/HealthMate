import 'package:client/component/buttons.dart';
import 'package:client/component/calendar/emotion_scroll.dart';
import 'package:client/pages/emotion_calendar/calendar.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

void showCustomDialog(BuildContext context) {
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
          child: dialogContent(context),
        ),
      );
    },
  );
}

Widget dialogContent(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
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
      mainAxisSize: MainAxisSize.min, // To make the dialog compact
      children: <Widget>[
        const Text(
          'เลือกอารมณ์ของคุณ', // Title
          style: FontTheme.subtitle2,
        ),
        const SizedBox(height: 16.0),
        const Text(
          '27 กุมภาพันธ์ 2567', // Date
          style: FontTheme.subtitle1,
        ),
        EmotionScoll(),
        const TextField(
          decoration: InputDecoration(
            hintText: 'รายละเอียดอารมณ์ของคุณ', // Placeholder
            hintStyle: FontTheme.body1,
          ),
        ),
        const SizedBox(height: 24.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SmPrimaryButton(
            text: 'บันทึก',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    ),
  );
}
