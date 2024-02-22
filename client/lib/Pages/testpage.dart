import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      locale: Locale('th'), // Set the locale to Thai
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // Add additional delegates for other localizations if needed
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('th'), // Thai
        // Add additional supported locales here
      ],
      home: CalendarScreen(),
    );
  }
}
