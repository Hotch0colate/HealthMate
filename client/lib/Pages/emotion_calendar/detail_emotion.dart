import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../component/calendar/emotion_card.dart'; // Make sure to import EmotionCard widget

class EmotionDetailPage extends StatelessWidget {
  final DateTime selectedDay;
  final List<Map<String, dynamic>> emotionsData; // A list to hold your emotions data

  const EmotionDetailPage({
    super.key,
    required this.selectedDay,
    required this.emotionsData, // Accepting emotions data as a parameter
  });

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('th', null); // Initialize Thai locale

    // Get the year from selectedDay
    int selectedYear = selectedDay.year;

    // Convert the year to Buddhist Era (B.E.)
    int buddhistEraYear = selectedYear + 543;

    // Format the date using the Thai locale and the new Buddhist Era year
    String formattedDate = DateFormat('d MMMM ', 'th').format(selectedDay) + '$buddhistEraYear';

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Text(
              formattedDate,
              style: FontTheme.subtitle1,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: emotionsData.length,
              itemBuilder: (BuildContext context, int index) {
                // Assuming your data map fits the EmotionCard parameters
                return EmotionCard(
                  time: emotionsData[index]['time'],
                  name: emotionsData[index]['name'],
                  description: emotionsData[index]['description'],
                  icon: emotionsData[index]['icon'], // Make sure this is an IconData object
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}