class SmallEmotions {
  final DateTime dateTime;
  final String emotion;

  const SmallEmotions({
    required this.dateTime,
    required this.emotion,
  });
  static List<SmallEmotions> small_emotions = [
    SmallEmotions(
      dateTime: DateTime.utc(2567, 2, 27, 12, 50, 0),
      emotion: 'assets/emotion/emotion_calendar/c_Angry.png',
    ),
    SmallEmotions(
      dateTime: DateTime.utc(2567, 2, 1, 12, 50, 0),
      emotion: 'assets/emotion/emotion_calendar/c_Angry.png',
    ),
    SmallEmotions(
      dateTime: DateTime.utc(2567, 3, 24, 12, 50, 0),
      emotion: 'assets/emotion/emotion_calendar/c_Tired.png',
    ),
    SmallEmotions(
      dateTime: DateTime.utc(2566, 12, 22, 12, 0, 0),
      emotion: 'assets/emotion/emotion_calendar/c_Sad.png',
    ),
    SmallEmotions(
      dateTime: DateTime.utc(2567, 2, 28, 12, 0, 0),
      emotion: 'assets/emotion/emotion_calendar/c_Excited.png',
    ),
  ];
}
