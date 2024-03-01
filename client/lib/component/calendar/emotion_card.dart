import 'package:client/models/emotion_model.dart';
import 'package:client/pages/emotion_calendar/edit_emotion.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmotionCard extends StatelessWidget {
  final Emotions emotions;

  const EmotionCard({
    Key? key,
    required this.emotions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 150,
      child: GestureDetector(
        onTap: () {
          EmotionDetailsDialog.show(context, emotions);
        },
        child: Card(
          color: ColorTheme.WhiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.more_horiz,
                  color: ColorTheme.primaryColor,
                ),
                Text(
                  DateFormat('HH:mm').format(emotions.dateTime),
                  style: FontTheme.body2,
                ),
                Image.asset(
                    'assets/emotion/emotion_text/m_${emotions.emotion}_t.png',
                  height: 80, // Set the desired height
                  width: 80, // Set the desired width
                ),
                Text(
                  emotions.detail.length > 30
                      ? '${emotions.detail.substring(0, 30)}...'
                      : emotions.detail,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, fontFamily: 'Athiti'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
