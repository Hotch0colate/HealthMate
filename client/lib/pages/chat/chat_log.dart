import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:intl/intl.dart';

//component import
import 'package:client/component/conversation_list.dart';

void main() {
  runApp(ChatLog(uid: '',));
}


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
    print(widget.uid);
    _database
        .child('users/' + widget.uid + '/chatgroup')
        .onValue
        .listen((event) {
      var snapshotValue = event.snapshot.value;
      if (snapshotValue != null && snapshotValue is List<dynamic>) {
        List<String> parsedChatgroup = List<String>.from(snapshotValue);

        List<Future<dynamic>> chatFutures = parsedChatgroup.map((cid) {
          return _database
              .child('chats/$cid')
              .get()
              .then((DataSnapshot snapshot) {
            if (snapshot.value != null) {
              return snapshot.value;
            }
            return null;
          });
        }).toList();

        Future.wait(chatFutures).then((List<dynamic> conversations) {
          var validConversations = conversations
              .where((conversation) => conversation != null)
              .map((conversation) {
                Map<String, dynamic> conversationMap;
                try {
                  conversationMap = Map<String, dynamic>.from(conversation);
                  return ConversationBox.fromMap(conversationMap);
                } catch (e) {
                  print("Error converting conversation data: $e");
                  return null;
                }
              })
              .whereType<ConversationBox>()
              .toList();

          _chatlogStreamController.add(validConversations);
        });
      } else {
        print('Invalid snapshot value or format chatlog');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "กล่องข้อความ",
                      style:
                          FontTheme.h2.copyWith(color: ColorTheme.primaryColor),
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
                        return b.date.compareTo(a.date);
                      }

                      // 3. If "seen" values are both true, compare "date" values (newer dates should come first)
                      if (seenComparison == 0 && a.seen) {
                        return b.date.compareTo(a.date);
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
                          imageURL: "assets/avatar/md_11",
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
