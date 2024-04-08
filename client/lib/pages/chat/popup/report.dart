import 'package:client/component/buttons.dart';
import 'package:client/component/calendar/emotion_scroll.dart';
import 'package:client/component/select_box.dart';
import 'package:client/pages/chat/popup/end_conversation.dart';
import 'package:client/pages/chat/popup/rating.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportDialog extends StatefulWidget {
  const ReportDialog({super.key});

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  bool bullying_and_harassment = false;
  bool hate_speech = false;
  bool spam = false;
  bool private_benefit = false;


  @override
  Widget build(BuildContext context) {
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
  }
  Widget dialogContent(BuildContext context) {

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
            setState(() {
                bullying_and_harassment = value; // Update the state when the checkbox state changes
                            });
          }, 
          value: bullying_and_harassment,
        ),
        SizedBox(height: 4,),
        ColorChangingCheckbox(
          key: UniqueKey(),
          text: 'คำพูดแสดงความเกลียดชัง',
          onChanged: (bool value) {
            setState(() {
                hate_speech = value; // Update the state when the checkbox state changes
                            });
          }, 
          value: hate_speech,
        ),
        SizedBox(height: 4,),
        ColorChangingCheckbox(
          key: UniqueKey(),
          text: 'สแปม',
          onChanged: (bool value) {
            setState(() {
                spam = value; // Update the state when the checkbox state changes
                            });
          }, 
          value: spam,
        ),
        SizedBox(height: 4,),
        ColorChangingCheckbox(
          key: UniqueKey(),
          text: 'แสวงหาผลประโยชน์ส่วนตัว',
          onChanged: (bool value) {
            setState(() {
                private_benefit = value; // Update the state when the checkbox state changes
                            });
          }, 
          value: private_benefit,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: SmPrimaryButton(
            text: 'รายงานและจบการสนทนา',
            onPressed: () {
                  showRatingDialog(context);
            },
          ),
        ),
      ],
    ),
  );
}



}