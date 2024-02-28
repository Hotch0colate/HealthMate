import 'package:client/models/emotion_model_c.dart';
import 'package:client/theme/font.dart';
import 'package:client/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'detail_emotion.dart';

class ThaiCalendarWithTable extends StatefulWidget {
  const ThaiCalendarWithTable({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ThaiCalendarWithTableState createState() => _ThaiCalendarWithTableState();
}

class _ThaiCalendarWithTableState extends State<ThaiCalendarWithTable> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('th');
  }

  String _formatThaiYear(DateTime date) {
    final int thaiYear = date.year + 543;
    return DateFormat.yMMMM('th_TH')
        .format(date)
        .replaceAll(RegExp(r'\d+'), thaiYear.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom header
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: ColorTheme.primaryColor,
                      size: 40,
                    ),
                    onPressed: () {
                      setState(() {
                        _focusedDay = DateTime(_focusedDay.year,
                            _focusedDay.month - 1, _focusedDay.day);
                      });
                    },
                  ),
                  // Display the Thai Buddhist year and month
                  Text(
                    _formatThaiYear(_focusedDay),
                    style: FontTheme.subtitle2
                        .copyWith(color: ColorTheme.primaryColor),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: ColorTheme.primaryColor,
                      size: 40,
                    ),
                    onPressed: () {
                      setState(() {
                        _focusedDay = DateTime(_focusedDay.year,
                            _focusedDay.month + 1, _focusedDay.day);
                      });
                    },
                  ),
                ],
              ),
            ),
            TableCalendar(
              locale: 'th_TH',
              calendarFormat: _calendarFormat,
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2021, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,
              headerVisible: false,
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(),
                todayDecoration: const BoxDecoration(
                    color: ColorTheme.primaryColor, shape: BoxShape.circle),
                selectedTextStyle: TextStyle(color: ColorTheme.baseColor),
                todayTextStyle:
                    FontTheme.body1.copyWith(color: ColorTheme.WhiteColor),
              ),
              headerStyle: HeaderStyle(
                titleTextStyle: FontTheme.subtitle2
                    .copyWith(color: ColorTheme.primaryColor),
                leftChevronIcon: const Icon(
                  Icons.arrow_back_ios,
                  color: ColorTheme.primaryColor,
                  size: 30,
                ),
                rightChevronIcon: const Icon(
                  Icons.arrow_forward_ios,
                  color: ColorTheme.primaryColor,
                  size: 30,
                ),
                titleCentered: true,
                formatButtonVisible: false,
              ),
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });

                final int thaiBuddhistYear = _selectedDay!.year + 543;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmotionDetailPage(
                      selectedDay: _selectedDay!,
                      emotionsData: const [],
                    ),
                  ),
                );

                // Print the selected date in Thai Buddhist format to the console
                print('${_selectedDay!.day.toString().padLeft(2, '0')}/'
                    '${_selectedDay!.month.toString().padLeft(2, '0')}/'
                    '$thaiBuddhistYear');
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              calendarBuilders: CalendarBuilders(
                // Custom builder for 'today'
                todayBuilder: (context, date, _) {
                  var dateWithoutTime =
                      DateTime(date.year, date.month, date.day);
                  var emotionsForTheDay =
                      SmallEmotions.small_emotions.where((smallEmotion) {
                    var emotionDate = DateTime(
                      convertBuddhistYearToGregorian(
                          smallEmotion.dateTime.year),
                      smallEmotion.dateTime.month,
                      smallEmotion.dateTime.day,
                    );
                    return isSameDay(emotionDate, dateWithoutTime);
                  }).toList();

                  // If there are emotions for 'today', do not show the todayDecoration
                  if (emotionsForTheDay.isNotEmpty) {
                    return Center(
                      child: Text(
                        DateFormat('d').format(date),
                        style: TextStyle(color: ColorTheme.primaryColor),
                      ),
                    );
                  } else {
                    // Apply todayDecoration if there are no emotions for today
                    return Container(
                      decoration: BoxDecoration(
                        color: ColorTheme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          DateFormat('d').format(date),
                          style: TextStyle(color: ColorTheme.WhiteColor),
                        ),
                      ),
                    );
                  }
                },

                // Use markerBuilder to add emotion stickers to dates
                markerBuilder: (context, date, events) {
                  var dateWithoutTime =
                      DateTime(date.year, date.month, date.day);
                  var emotionsForTheDay =
                      SmallEmotions.small_emotions.where((smallEmotion) {
                    var emotionDate = DateTime(
                      convertBuddhistYearToGregorian(
                          smallEmotion.dateTime.year),
                      smallEmotion.dateTime.month,
                      smallEmotion.dateTime.day,
                    );
                    return isSameDay(emotionDate, dateWithoutTime);
                  }).toList();

                  if (emotionsForTheDay.isNotEmpty) {
                    // Return a widget (e.g., an image) to indicate the emotion
                    return Positioned(
                      right: 1,
                      bottom: 10,
                      child: Image.asset(
                        emotionsForTheDay.first
                            .emotion, // Taking the first emotion for simplicity
                        width: 50, // Adjust size accordingly
                      ),
                    );
                  }

                  return null; // Return null to not show anything if there's no emotion for the day
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int convertBuddhistYearToGregorian(int buddhistYear) {
  return buddhistYear - 543;
}
