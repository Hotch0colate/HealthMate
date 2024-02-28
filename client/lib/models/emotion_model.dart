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
    Emotions (
        dateTime: DateTime.utc(2567, 2, 27, 12, 50, 0),
        emotion: 'assets/emotion/emotion_text/m_Angry_t.png',
        detail: 'โกรธรายละเอียด'),
    Emotions(
        dateTime: DateTime.utc(2567, 2, 24, 12, 50, 0),
        emotion: 'assets/emotion/emotion_text/m_Tired_t.png',
        detail: 'เหนื่อยรายละเอียด'),
    Emotions(
        dateTime: DateTime.utc(2567, 2, 22, 12, 0, 0),
        emotion: 'assets/emotion/emotion_text/m_Sad_t.png',
        detail: 'เศร้ารายละเอียด'),
    Emotions(
        dateTime: DateTime.utc(2567, 2, 27, 12, 0, 0),
        emotion: 'assets/emotion/emotion_text/m_Happy_t.png',
        detail: 'มีความสุขรายละเอียด'),
  ];
}
