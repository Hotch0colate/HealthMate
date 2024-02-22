import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:client/Pages/chat_room.dart';
import 'package:client/theme/color.dart';

// ignore: must_be_immutable
class ConversationBox extends StatefulWidget {
  String name;
  final String cid;
  final String uid;
  // final String user;
  // final String volunteer;
  final bool complete;
  final bool seen;
  final String lastmessage;
  final String lastsender;
  // final List<Message> messages;
  // final int mil;
  final String imageURL;
  final String date;

  @override
  _ConversationBoxState createState() => _ConversationBoxState();

  ConversationBox(
      {required this.name,
      required this.cid,
      required this.uid,
      // required this.user,
      // required this.volunteer,
      required this.complete,
      required this.seen,
      required this.lastmessage,
      required this.lastsender,
      // required this.messages,
      // required this.mil,
      required this.imageURL,
      required this.date});

  factory ConversationBox.fromMap(Map<String, dynamic> map) {
    return ConversationBox(
      name: map['name'] ??
          '', // ตรวจสอบและกำหนดค่าเริ่มต้นให้เป็น '' หากไม่มีค่าใน map
      cid: map['cid'] ?? '',
      uid: map['uid'] ?? '',
      // user: map['user'] ?? '',
      // volunteer: map['volunteer'] ?? '',
      complete: map['complete'] ??
          false, // ตรวจสอบและกำหนดค่าเริ่มต้นให้เป็น false หากไม่มีค่าใน map
      seen: map['seen'] ?? false,
      lastmessage: map['lastmessage'] ?? '',
      lastsender: map['lastsender'] ?? '',
      // messages: (map['messages'] as List<dynamic>?)
      //         ?.map((msg) => Message.fromMap(msg))
      //         ?.toList() ??
      //     [],
      // mil: map['mil'] ??
      //    0, // ตรวจสอบและกำหนดค่าเริ่มต้นให้เป็น 0 หากไม่มีค่าใน map
      imageURL: map['imageURL'] ?? '',
      date: map['date'] ?? '',
    );
  }
}

class _ConversationBoxState extends State<ConversationBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoom(
                cid: widget.cid, uid: widget.uid, messages: []

                // ใส่โค้ดที่คุณต้องการทำเมื่อได้รับผลลัพธ์จาก ChatRoom ที่นี่
                ), // Assuming Chatroom is your chat room page
          ),
        );
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageURL),
                    maxRadius: 30,
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.lastmessage,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: widget.seen
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.date,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight:
                      widget.seen ? FontWeight.bold : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}

// class Chat {
//   final String cid;
//   final String user;
//   final String volunteer;
//   final bool complete;
//   final bool seen;
//   final int mil;
//   final String date;

//   Chat(
//       {required this.cid,
//       required this.user,
//       required this.volunteer,
//       required this.complete,
//       required this.seen,
//       required this.mil,
//       required this.date});

//   factory Chat.fromMap(Map<String, dynamic> map) {
//     return Chat(
//         text: map['text'],
//         sender: map['sender'],
//         date: map['date'],
//         mid: map['mid'],
//         mil: map['mil'],
//         seen: map['seen']);
//   }
// }