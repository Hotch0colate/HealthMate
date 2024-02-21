import 'package:flutter/material.dart';

class FontTheme {
  FontTheme._();

  static const TextStyle h1 = TextStyle(
    fontFamily: 'Athiti',
    fontWeight: FontWeight.w700,
    fontSize: 60,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: 'Athiti',
    fontWeight: FontWeight.w600,
    fontSize: 48,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: 'Athiti',
    fontWeight: FontWeight.w600,
    fontSize: 36,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontFamily: 'Athiti',
    fontWeight: FontWeight.w800,
    fontSize: 24,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: 'Athiti',
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: 'Athiti',
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: 'Athiti',
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'Athiti',
    fontWeight: FontWeight.w600,
    fontSize: 16,
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
                'กราบสวัสดี H1',
                style: FontTheme.h1,
              ),
              Text(
                'กราบสวัสดี H2',
                style: FontTheme.h2,
              ),
              Text(
                'คุณชื่ออะไร',
                style: FontTheme.h3,
              ),
              Text(
                'กราบสวัสดีsubtitle1',
                style: FontTheme.subtitle1,
              ),
              Text(
                'กราบสวัสดีsubtitle2',
                style: FontTheme.subtitle2,
              ),              
              Text(
                'กราบสวัสดีbody',
                style: FontTheme.body1,
              ),
              Text(
                'กราบสวัสดีbody',
                style: FontTheme.body2,
              ),  
              Text(
                'กราบสวัสดีcaption',
                style: FontTheme.caption,
              ),  
                        
            ],
          ),
        ),
      ),
    );
  }
}
