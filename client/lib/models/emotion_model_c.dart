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
  // static List<SmallEmotions> small_emotions = [

  //   SmallEmotions(
  //     dateTime: DateTime.utc(2567, 2, 27, 12, 50, 0),
  //     emotion: 'Angry',
  //   ),
  //   SmallEmotions(
  //     dateTime: DateTime.utc(2567, 2, 27, 20, 50, 0),
  //     emotion: 'Sad',
  //   ),

  //   SmallEmotions(
  //     dateTime: DateTime.utc(2567, 2, 1, 12, 50, 0),
  //     emotion: 'Angry',
  //   ),
  //   SmallEmotions(
  //     dateTime: DateTime.utc(2567, 2, 15, 12, 50, 0),
  //     emotion: 'Tired',
  //   ),
  //   SmallEmotions(
  //     dateTime: DateTime.utc(2567, 2, 15, 12, 0, 0),
  //     emotion: 'Sad',
  //   ),
  //   SmallEmotions(
  //     dateTime: DateTime.utc(2567, 2, 28, 12, 0, 0),
  //     emotion: 'Excited',
  //   ),
  // ];
}
