import 'package:intl/intl.dart';

class Emotions {
  final DateTime dateTime;
  final String emotion;
  final String detail;
  final String eid;

  const Emotions(
      {required this.dateTime,
      required this.emotion,
      required this.detail,
      required this.eid});

  factory Emotions.fromJson(Map<String, dynamic> json) {
    // Assuming the date format in the JSON is "d/M/yyyy HH:mm:ss"
    final dateFormat = DateFormat("d/M/yyyy HH:mm:ss");
    return Emotions(
      dateTime: dateFormat.parse(json['time'], true).toLocal(),
      emotion: json['emotion'],
      detail: json['description'],
      eid: json['eid'],
    );
  }
}
