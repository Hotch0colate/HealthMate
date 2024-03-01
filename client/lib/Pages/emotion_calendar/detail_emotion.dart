import 'package:client/models/emotion_model.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:client/component/calendar/emotion_card.dart';

class EmotionDetailPage extends StatelessWidget {
  final DateTime date;
  final List<Map<String, dynamic>> emotionsData;

  const EmotionDetailPage({
    super.key,
    required this.date,
    required this.emotionsData,
  });

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('th', null);

    // Calculate the Thai (Buddhist) year and Gregorian year
    int thaiYear = date.year + 543;

    String formattedDateThai =
        '${DateFormat('d MMMM ', 'th').format(date)}$thaiYear';

    // Filter emotions for the selected day
    List<Emotions> selectedDayEmotions = Emotions.emotions.where((emotion) {
      return emotion.dateTime.year == date.year &&
          emotion.dateTime.month == date.month &&
          emotion.dateTime.day == date.day;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios, // Replace with your custom icon
            color: ColorTheme.baseColor,
            size: 30, // Customize the icon color
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: ColorTheme.WhiteColor,
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  formattedDateThai,
                  style: FontTheme.h3.copyWith(color: ColorTheme.primaryColor),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: selectedDayEmotions.map((emotion) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: EmotionCard(emotions: emotion),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
