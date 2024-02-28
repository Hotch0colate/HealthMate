import 'package:client/models/emotion_model.dart';
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
    return Container(
      height: 200,
      width: 150,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                DateFormat('HH:MM').format(emotions.dateTime),
                style: FontTheme.body2,
              ),
              // Here, we're using an icon as a placeholder. You should replace this with an Image widget if you have an image.
              Image.asset(
                emotions.emotion,
                height: 80, // Set the desired height
                width: 80, // Set the desired width
              ),
              Text(
                emotions.detail.length > 30
                    ? '${emotions.detail.substring(0, 30)}...'
                    : emotions.detail,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, fontFamily: 'Athiti'),
              ),
              const Icon(Icons.more_horiz,color: ColorTheme.primaryColor,)
            ],
          ),
        ),
      ),
    );
  }
}
