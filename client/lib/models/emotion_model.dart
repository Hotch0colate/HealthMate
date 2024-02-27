class Emotions {
  late final DateTime dateTime;
  late final String emotion;
  late final String detail;

  Emotions({
    required this.dateTime,
    required this.emotion,
    required this.detail,
  });
}

void main() {
  // Create a specific instance of Emotions with date and time
  Emotions specificEmotion = Emotions(
    dateTime: DateTime(2024, 2, 27, 12, 30), // February 27, 2024, 12:30 PM
    emotion: 'Angry',
    detail: 'ไม่ชอบ',
  );

  // Print the specific instance
  print('DateTime: ${specificEmotion.dateTime}, Emotion: ${specificEmotion.emotion}, Detail: ${specificEmotion.detail}');
}