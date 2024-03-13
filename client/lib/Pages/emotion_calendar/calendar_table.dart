import 'dart:async';
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

final GlobalKey<_ThaiCalendarWithTableState> calendarKey =
    GlobalKey<_ThaiCalendarWithTableState>();

class ThaiCalendarWithTable extends StatefulWidget {
  const ThaiCalendarWithTable({super.key});

  @override
  _ThaiCalendarWithTableState createState() => _ThaiCalendarWithTableState();
}

class _ThaiCalendarWithTableState extends State<ThaiCalendarWithTable> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  late Stream<List<SmallEmotions>> _emotionsStream;
  late StreamController<List<SmallEmotions>> _emotionsController;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('th');
    _emotionsController = StreamController<List<SmallEmotions>>();
    _emotionsStream = _emotionsController.stream;
    _fetchEmotions();
  }

  @override
  void dispose() {
    _emotionsController.close();
    super.dispose();
  }

  void refreshEmotions() {
    print("refreshing emotions");
    setState(() {
      _fetchEmotions();
    });
    // _fetchEmotions();
  }

  String _formatThaiYear(DateTime date) {
    final int thaiYear = date.year + 543;
    return DateFormat.yMMMM('th_TH')
        .format(date)
        .replaceAll(RegExp(r'\d+'), thaiYear.toString());
  }

  Future<void> _fetchEmotions() async {
    try {
      var _auth_service = AuthService();
      String? token = await _auth_service.getIdToken();

      final response = await http.post(
        Uri.parse('http://${fixedIp}:3000/emotion/read_all_data'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body)['Data'];
        List<SmallEmotions> emotions = [];

        data.forEach((dateStr, emotion) {
          if (emotion != null) {
            DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(dateStr);
            emotions.add(SmallEmotions(dateTime: parsedDate, emotion: emotion));
          }
        });
        _emotionsController.add(emotions);
        _emotionsStream = _emotionsController.stream;
      } else {
        throw Exception('Failed to load emotions');
      }
    } catch (error) {
      throw Exception('Failed to load emotions: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<SmallEmotions>>(
        stream: _emotionsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<SmallEmotions> unformatEmotions = snapshot.data ?? [];
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          color: ColorTheme.primaryColor,
                          shape: BoxShape.circle),
                      selectedTextStyle:
                          const TextStyle(color: ColorTheme.baseColor),
                      todayTextStyle: FontTheme.body1
                          .copyWith(color: ColorTheme.WhiteColor),
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

                      print('${_selectedDay!.day.toString().padLeft(2, '0')}/'
                          '${_selectedDay!.month.toString().padLeft(2, '0')}/'
                          '$thaiBuddhistYear');
                    },
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    calendarBuilders: CalendarBuilders(
                      todayBuilder: (context, date, _) {
                        var dateWithoutTime =
                            DateTime(date.year, date.month, date.day);
                        var formattedEmotion =
                            unformatEmotions.where((smallEmotion) {
                          var emotionDate = DateTime(
                            convertBuddhistYearToGregorian(
                                smallEmotion.dateTime.year),
                            smallEmotion.dateTime.month,
                            smallEmotion.dateTime.day,
                          );
                          return isSameDay(emotionDate, dateWithoutTime);
                        }).toList();

                        if (formattedEmotion.isNotEmpty) {
                          return Center(
                            child: Text(
                              DateFormat('d').format(date),
                              style: const TextStyle(
                                  color: ColorTheme.primaryColor),
                            ),
                          );
                        } else {
                          return Container(
                            decoration: const BoxDecoration(
                              color: ColorTheme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                DateFormat('d').format(date),
                                style: const TextStyle(
                                    color: ColorTheme.WhiteColor),
                              ),
                            ),
                          );
                        }
                      },
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
                          formattedEmotion
                              .sort((a, b) => b.dateTime.compareTo(a.dateTime));

                          return Positioned(
                            right: 1,
                            bottom: 10,
                            child: Image.asset(
                              'assets/emotion/emotion_calendar/c_${formattedEmotion.first.emotion}.png',
                              width: 50,
                            ),
                          );
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

int convertBuddhistYearToGregorian(int buddhistYear) {
  return buddhistYear - 543;
}
