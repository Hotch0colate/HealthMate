import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthMate Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HealthCalendar(),
    );
  }
}

class HealthCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HEALTHMATE'),
      ),
      body: Column(
        children: <Widget>[
          // You can use a package like table_calendar for a more customizable calendar
          TableCalendar(
              focusedDay: DateTime.utc(2024, 2, 2),
              firstDay: DateTime.utc(2021, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
            // Configure the calendar here
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, // One for each day of the week
              ),
              itemCount: 30, // The number of days to show in the grid
              itemBuilder: (context, index) {
                return Container(
                  // This is where you would customize each cell in the calendar grid
                  child: Center(
                    child: Text('${index + 1}'), // Day number
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Let\'s record your first day of good health!'),
          ),
          FloatingActionButton(
            onPressed: () {
              // Action to add a new health record
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
