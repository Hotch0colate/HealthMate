import 'package:client/component/buttons.dart';
import 'package:client/component/calendar/emotion_scroll.dart';
import 'package:client/component/select_box.dart';
import 'package:client/pages/chat/popup/end_conversation.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String currentSelectedEmotion = '';
TextEditingController descriptionController = TextEditingController();

void showReportDialog(BuildContext context) {
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
          child: dialogContent(context),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'รายงานผู้ใช้',
              style: FontTheme.body1,
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        SizedBox(height: 8,),
        ColorChangingCheckbox(
          key: UniqueKey(),
          text: 'กลั่นแกล้งและคุกคาม',
          onChanged: (bool value) {
            // Callback when checkbox state changes
            print('Checkbox state changed: $value');
          },
        ),
        SizedBox(height: 4,),
        ColorChangingCheckbox(
          key: UniqueKey(),
          text: 'คำพูดแสดงความเกลียดชัง',
          onChanged: (bool value) {
            // Callback when checkbox state changes
            print('Checkbox state changed: $value');
          },
        ),
        SizedBox(height: 4,),
        ColorChangingCheckbox(
          key: UniqueKey(),
          text: 'สแปม',
          onChanged: (bool value) {
            // Callback when checkbox state changes
            print('Checkbox state changed: $value');
          },
        ),
        SizedBox(height: 4,),
        ColorChangingCheckbox(
          key: UniqueKey(),
          text: 'แสวงหาผลประโยชน์ส่วนตัว',
          onChanged: (bool value) {
            // Callback when checkbox state changes
            print('Checkbox state changed: $value');
          },
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: SmPrimaryButton(
            text: 'รายงาน',
            onPressed: () {
                  showEndcConvarsationDialog(context);
            },
          ),
        ),
      ],
    ),
  );
}
