import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:client/component/buttons.dart';
import 'package:client/component/text_field/grey_text_field.dart';
import 'package:client/models/emotion_model.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';

class EmotionDetailsDialog {
  static void show(BuildContext context, Emotions emotions) {
    TextEditingController _controller =
        TextEditingController(text: emotions.detail);

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
                        // Text(
                        //   _formatThaiYear(emotions.dateTime),
                        //   style: FontTheme.subtitle2
                        //       .copyWith(color: ColorTheme.primaryColor),
                        // ),
                        SizedBox(width: 60,),
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
                          onPressed: () {},
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
}
