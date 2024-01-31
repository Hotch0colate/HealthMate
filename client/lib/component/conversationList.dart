import 'package:flutter/material.dart';
import 'package:client/Pages/chatroom.dart';
import 'package:client/theme/theme.dart';

// ignore: must_be_immutable
class ConversationBox extends StatefulWidget {
  @override
  _ConversationBoxState createState() => _ConversationBoxState();

  String name;
  final String cid;
  final String uid;
  String messageText;
  String imageURL;
  String date;
  bool seen;
  ConversationBox(
      {required this.name,
      required this.cid,
      required this.uid,
      required this.messageText,
      required this.imageURL,
      required this.date,
      required this.seen});
}

class _ConversationBoxState extends State<ConversationBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoom(
              cid: widget.cid,
              uid: widget.uid,
              messages: [],
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
                            widget.messageText,
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
