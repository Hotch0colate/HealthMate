import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

//page import
import 'package:client/pages/chat/chat_room.dart';

import 'package:client/theme/color.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

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
    String time = ''; // Initialize an empty string to hold the formatted time

    // Check if the date string is not empty
    if (widget.date.isNotEmpty) {
      // Split the date string into date and time parts using space as the separator
      List<String> parts = widget.date.split(' ');

      // Check if the parts contain time
      if (parts.length == 2) {
        // Extract the time part
        String timePart = parts[1];
        // Extract only the HH:mm part from the time
        time = timePart.split(':')[0] + ':' + timePart.split(':')[1];
      }
    }

    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChatRoom(cid: widget.cid, uid: widget.uid, messages: []),
          ),
        );
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Row(
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
                                style: FontTheme.body1,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(widget.lastmessage,
                                      style: FontTheme.body2.copyWith(
                                          fontWeight: widget.seen
                                              ? FontWeight.bold
                                              : FontWeight.normal)),
                                  Text(
                                    time,
                                    style: FontTheme.caption.copyWith(
                                      fontWeight: widget.seen
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
