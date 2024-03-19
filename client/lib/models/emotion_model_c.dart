class SmallEmotions {
  final DateTime dateTime;
  final String emotion;

  const SmallEmotions({
    required this.dateTime,
    required this.emotion,
  });

  factory SmallEmotions.fromJson(Map<String, dynamic> json) {
    return SmallEmotions(
      dateTime: DateTime.parse(json['date']),
      emotion: json['emotion'],
    );
  }
}
