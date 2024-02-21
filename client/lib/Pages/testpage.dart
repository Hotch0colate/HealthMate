import 'package:flutter/material.dart';

class FontTheme {
  FontTheme._();

  static const TextStyle h1 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 48,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 32,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );

  static const TextStyle h5 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  static const TextStyle overline = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    wordSpacing: 1.2,
  );
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Font Theme Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'สวัสดี',
                style: FontTheme.h1,
              ),
              Text(
                'Heading 2',
                style: FontTheme.h2,
              ),
              Text(
                'Heading 3',
                style: FontTheme.h3,
              ),
              Text(
                'Subtitle 1',
                style: FontTheme.subtitle1,
              ),
              Text(
                'Body Text',
                style: FontTheme.body1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
