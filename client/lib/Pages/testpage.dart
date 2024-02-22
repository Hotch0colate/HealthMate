import 'package:client/theme/font.dart';
import 'package:client/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(MaterialApp(
    home: const ThaiCalendarWithTable(),
  ));
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              locale: 'th_TH', // กำหนด locale เป็นภาษาไทย
              calendarFormat: _calendarFormat,
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2021, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorTheme.primaryColor.withOpacity(0.5),
                ),
                todayDecoration: BoxDecoration(
                  color: ColorTheme.primaryColor,
                  shape: BoxShape.circle
                ),
                selectedTextStyle:
                    FontTheme.body1.copyWith(color: ColorTheme.WhiteColor),
                todayTextStyle:
                    FontTheme.body1.copyWith(color: ColorTheme.WhiteColor),
              ),
              headerStyle: HeaderStyle(
                titleTextStyle:
                    FontTheme.h3.copyWith(color: ColorTheme.primaryColor),
                leftChevronIcon: const Icon(
                  Icons.arrow_back_ios,
                  color: ColorTheme.primaryColor,
                  size: 30,
                ), // Modify left chevron icon color
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
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              calendarBuilders: CalendarBuilders(
                outsideBuilder: (context, date, _) {
                  return const SizedBox.shrink(); // Hide days outside the current month
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
