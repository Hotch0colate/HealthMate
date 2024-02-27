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
              padding: EdgeInsets.all(16),
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
                selectedDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorTheme.primaryColor.withOpacity(0.5),
                ),
                todayDecoration: const BoxDecoration(
                    color: ColorTheme.primaryColor, shape: BoxShape.circle),
                selectedTextStyle:
                    FontTheme.body1.copyWith(color: ColorTheme.WhiteColor),
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
                      selectedDay: _selectedDay!, emotionsData: [],
                    ),
                  ),
                );

                // Print the selected date in Thai Buddhist format to the console
                print('${_selectedDay!.day.toString().padLeft(2, '0')}/'
                    '${_selectedDay!.month.toString().padLeft(2, '0')}/'
                    '${thaiBuddhistYear}');
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              calendarBuilders: CalendarBuilders(
                outsideBuilder: (context, date, _) {
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
