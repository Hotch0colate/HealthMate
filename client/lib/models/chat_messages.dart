// ignore: file_names
class Message {
  String senderID;
  String text;
  DateTime date; // Add timestamp to ChatMessage
  bool seen;

  Message(
      {required this.senderID,
      required this.text,
      required this.date,
      required this.seen});
}
