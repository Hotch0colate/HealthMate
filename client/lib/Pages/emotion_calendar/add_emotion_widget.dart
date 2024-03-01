import 'package:client/component/buttons.dart';
import 'package:client/component/calendar/emotion_scroll.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        EmotionScoll(),
        const TextField(
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
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    ),
  );
}
