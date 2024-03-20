import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Text Field',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Simple Text Field'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Enter your text:',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}