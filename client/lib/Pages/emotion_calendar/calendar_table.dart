import 'dart:convert';

import 'package:client/services/auth_service.dart';
import 'package:client/services/ip_variable.dart';
import 'package:http/http.dart' as http;

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
  List<SmallEmotions> unformatEmotions = [];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('th');
    _fetchAndSetUid();
  }

  String _formatThaiYear(DateTime date) {
    final int thaiYear = date.year + 543;
    return DateFormat.yMMMM('th_TH')
        .format(date)
        .replaceAll(RegExp(r'\d+'), thaiYear.toString());
  }

  void _fetchAndSetUid() async {
    // สมมติว่าคุณมีฟังก์ชัน `getToken` ที่สามารถดึง token ของผู้ใช้
    var _auth_service = AuthService();
    String? token = await _auth_service.getIdToken();
    await recievedAllEmotionCalendar(token);
  }

  Future<void> recievedAllEmotionCalendar(String? token) async {
    try {
      final response = await http.post(
          Uri.parse('http://${fixedIp}:3000/emotion/read_all_data'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token', // ส่ง token ใน header
          });

      if (response.statusCode == 200) {
        print('Received each last emotion of each day successfully');
        Map<String, dynamic> data = json.decode(response.body)['Data'];

        data.forEach((dateStr, emotion) {
          if (emotion != null) {
            // Assuming the date comes in the format "dd-MM-yyyy"
            DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(dateStr);
            unformatEmotions
                .add(SmallEmotions(dateTime: parsedDate, emotion: emotion));
          }
        });
      } else {
        print('Error recieving: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error recieving: $error');
    }
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
                selectedDecoration: const BoxDecoration(),
                todayDecoration: const BoxDecoration(
                    color: ColorTheme.primaryColor, shape: BoxShape.circle),
                selectedTextStyle: const TextStyle(color: ColorTheme.baseColor),
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
                    builder: (context) =>
                        EmotionDetailPage(date: _selectedDay!),
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
                  var formattedEmotion = unformatEmotions.where((smallEmotion) {
                    var emotionDate = DateTime(
                      convertBuddhistYearToGregorian(
                          smallEmotion.dateTime.year),
                      smallEmotion.dateTime.month,
                      smallEmotion.dateTime.day,
                    );
                    return isSameDay(emotionDate, dateWithoutTime);
                  }).toList();

                  // If there are emotions for 'today', do not show the todayDecoration
                  if (formattedEmotion.isNotEmpty) {
                    return Center(
                      child: Text(
                        DateFormat('d').format(date),
                        style: const TextStyle(color: ColorTheme.primaryColor),
                      ),
                    );
                  } else {
                    // Apply todayDecoration if there are no emotions for today
                    return Container(
                      decoration: const BoxDecoration(
                        color: ColorTheme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          DateFormat('d').format(date),
                          style: const TextStyle(color: ColorTheme.WhiteColor),
                        ),
                      ),
                    );
                  }
                },

                // Use markerBuilder to add emotion stickers to dates
                markerBuilder: (context, date, events) {
                  var dateWithoutTime =
                      DateTime(date.year, date.month, date.day);
                  var formattedEmotion = unformatEmotions
                      .where((smallEmotion) => isSameDay(
                            DateTime(
                              convertBuddhistYearToGregorian(
                                  smallEmotion.dateTime.year),
                              smallEmotion.dateTime.month,
                              smallEmotion.dateTime.day,
                            ),
                            dateWithoutTime,
                          ))
                      .toList();

                  if (formattedEmotion.isNotEmpty) {
                    // Sort emotions for the day by dateTime in descending order
                    formattedEmotion
                        .sort((a, b) => b.dateTime.compareTo(a.dateTime));

                    return Positioned(
                      right: 1,
                      bottom: 10,
                      child: Image.asset(
                        'assets/emotion/emotion_calendar/c_${formattedEmotion.first.emotion}.png',
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
