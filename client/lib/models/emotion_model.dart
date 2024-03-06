// class Emotions {
//   final DateTime dateTime;
//   final String emotion;
//   final String detail;

//   const Emotions({
//     required this.dateTime,
//     required this.emotion,
//     required this.detail,
//   });

//   factory Emotions.fromJson(Map<String, dynamic> json) {
//     return Emotions(
//       dateTime: DateTime.parse(json['dateTime']),
//       emotion: json['emotion'],
//       detail: json['detail'],
//     );
//   }
// static List<Emotions> emotions = [
//   Emotions (
//       dateTime: DateTime.utc(2024, 2, 27, 11, 36, 0),
//       emotion: 'Angry',
//       detail: 'โกรธรายละเอียด'),
//   Emotions(
//       dateTime: DateTime.utc(2024, 2, 24, 12, 50, 0),
//       emotion: 'Tired',
//       detail: 'เหนื่อยรายละเอียด'),
//   Emotions(
//       dateTime: DateTime.utc(2024, 2, 22, 23, 10, 0),
//       emotion: 'Sad',
//       detail: 'เศร้ารายละเอียด'),
//   Emotions(
//       dateTime: DateTime.utc(2024, 2, 27, 12, 50, 0),
//       emotion: 'Happy',
//       detail: 'มีความสุขรายละเอียด'),
// ];
// }

import 'package:intl/intl.dart';

class Emotions {
  final DateTime dateTime;
  final String emotion;
  final String detail;

  const Emotions({
    required this.dateTime,
    required this.emotion,
    required this.detail,
  });

  factory Emotions.fromJson(Map<String, dynamic> json) {
    // Assuming the date format in the JSON is "d/M/yyyy HH:mm:ss"
    final dateFormat = DateFormat("d/M/yyyy HH:mm:ss");
    return Emotions(
      dateTime: dateFormat.parse(json['time'], true).toLocal(),
      emotion: json['emotion'],
      detail: json['description'],
    );
  }
}
