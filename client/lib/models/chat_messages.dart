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

// List<Message> messages = [
//   Message(
//     text: "สวัสดี",
//     date: DateTime.now()
//         .subtract(Duration(minutes: 5)), // Use a timestamp for each message
//   ),
//   Message(
//     text: "คุณเป็นยังไงบ้าง",
//     date: DateTime.now().subtract(Duration(minutes: 3)),
//   ),
//   Message(
//     text: "ฉันสบายดีมากกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกก",
//     date: DateTime.now().subtract(Duration(minutes: 2)),
//   ),
//   Message(
//     text: "โอเคดีแล้ว.",
//     date: DateTime.now().subtract(Duration(minutes: 1)),
//   ),
//   Message(
//     text: "ขอบคุณสำหรับความช่วยเหลือจ้า",
//     date: DateTime.now(),
//   ),
// ];
