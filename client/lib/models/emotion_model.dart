class Emotions {
  final DateTime dateTime;
  final String emotion;
  final String detail;

  const Emotions({
    required this.dateTime,
    required this.emotion,
    required this.detail,
  });
  static List<Emotions> emotions = [
    Emotions(
        dateTime: DateTime.utc(2024, 2, 27, 12, 0, 0),
        emotion: 'Angry',
        detail: 'โกรธละเอียด'),
    Emotions(
        dateTime: DateTime.utc(2024, 2, 24, 12, 0, 0),
        emotion: 'Angry',
        detail: 'โกรธละเอียด'),
    Emotions(
        dateTime: DateTime.utc(2024, 2, 22, 12, 0, 0),
        emotion: 'Angry',
        detail: 'โกรธละเอียด'),
    Emotions(
        dateTime: DateTime.utc(2024, 2, 27, 12, 0, 0),
        emotion: 'Angry',
        detail: 'โกรธละเอียด'),
  ];
}