import 'package:flutter/material.dart';
import 'package:client/component/conversation_list.dart';
import 'package:firebase_database/firebase_database.dart';

import 'dart:async';

import 'package:intl/intl.dart';

typedef UpdateTriggerCallback = void Function(bool updateTrigger);

class ChatLog extends StatefulWidget {
  final String uid;
  @override
  _ChatLogState createState() => _ChatLogState();

  ChatLog({required this.uid});
}

class _ChatLogState extends State<ChatLog> {
  Key _streamBuilderKey = UniqueKey();
  StreamController<List<ConversationBox>> _chatlogStreamController =
      StreamController<List<ConversationBox>>();
  final _database = FirebaseDatabase.instance.reference();
  // bool _updateTrigger = false;

  @override
  void initState() {
    super.initState();

    _activeListeners();
  }

  @override
  void dispose() {
    _chatlogStreamController.close();

    super.dispose();
  }

  void _activeListeners() {
    _database
        .child('users/' + widget.uid + '/chatgroup')
        .onValue
        .listen((event) {
      var snapshotValue = event.snapshot.value;
      if (snapshotValue != null && snapshotValue is List<dynamic>) {
        List<dynamic> snapshotList = snapshotValue;

        List<String> parsedChatgroup = snapshotList.cast<String>();

        _database.child('chats/').onValue.listen((event) {
          var snapshotValue = event.snapshot.value;
          if (snapshotValue != null && snapshotValue is Map<String, dynamic>) {
            Map<String, dynamic> snapshotMap = snapshotValue;

            // ตัวอย่างการเข้าถึงข้อมูลใน messages
            dynamic chatData = snapshotMap;
            if (chatData != null) {
              Map<String, dynamic>? chatMap = chatData as Map<String, dynamic>?;
              if (chatMap != null) {
                List<ConversationBox> parsedChat = chatMap.values
                    .where((chat) => parsedChatgroup.contains(chat['cid']))
                    .map((chat) => ConversationBox.fromMap(chat))
                    .toList();
                _chatlogStreamController.add(parsedChat);
              }
            }
          }
        });
      } else {
        print('Invalid snapshot value or format');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "กล่องข้อความ",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder<List<ConversationBox>>(
                stream: _chatlogStreamController.stream,
                key: _streamBuilderKey,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return
                        //  const CircularProgressIndicator();

                        Container(
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          'No chats',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    List<ConversationBox> chatlogs = snapshot.data ?? [];
                    chatlogs.sort((a, b) {
                      // 1. Compare "seen" values (false should come before true)
                      int seenComparison = a.seen == b.seen
                          ? 0
                          : a.seen
                              ? 1
                              : !a.seen && a.lastsender == widget.uid
                                  ? 0
                                  : -1;

                      // 2. If "seen" values are both false, compare "date" values (newer dates should come first)
                      if (seenComparison == 0 && !a.seen) {
                        DateTime dateA =
                            DateFormat("dd/MM/yyyy HH:mm:ss").parse(a.date);
                        DateTime dateB =
                            DateFormat("dd/MM/yyyy HH:mm:ss").parse(b.date);

                        // Reverse the comparison to make newer dates come first
                        return dateB.compareTo(dateA);
                      }

                      // 3. If "seen" values are both true, compare "date" values (newer dates should come first)
                      if (seenComparison == 0 && a.seen) {
                        DateTime dateA =
                            DateFormat("dd/MM/yyyy HH:mm:ss").parse(a.date);
                        DateTime dateB =
                            DateFormat("dd/MM/yyyy HH:mm:ss").parse(b.date);

                        // Reverse the comparison to make newer dates come first
                        return dateB.compareTo(dateA);
                      }

                      return seenComparison;
                    });

                    return ListView.builder(
                      itemCount: chatlogs.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ConversationBox(
                          name: "ช่องแชท",
                          cid: chatlogs[index].cid,
                          uid: widget.uid,
                          // user: chatlogs[index].user,
                          // volunteer: chatlogs[index].volunteer,
                          complete: chatlogs[index].complete,
                          seen: chatlogs[index].seen,
                          lastmessage: chatlogs[index].lastmessage,
                          lastsender: chatlogs[index].lastsender,
                          // messages: [],
                          // mil: 0,
                          imageURL: "###",
                          date: chatlogs[index].date,
                        );
                      },
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
