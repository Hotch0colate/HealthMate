import 'package:client/component/buttons.dart';
import 'package:client/component/calendar/emotion_scroll.dart';
import 'package:client/pages/chat/popup/rating.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


void showEndcConvarsationDialog(BuildContext context) {
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
          child: dialogContent(context
          ),
        ),
      );
    },
  );
}

Widget dialogContent(BuildContext context) {
  // Get the current date
 
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
                  showRatingDialog(context);
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
