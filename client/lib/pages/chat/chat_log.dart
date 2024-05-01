import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:client/component/conversation_list.dart'; // Adjust to your actual path

class ChatLog extends StatefulWidget {
  final String uid;

  ChatLog({required this.uid});

  @override
  _ChatLogState createState() => _ChatLogState();
}

class _ChatLogState extends State<ChatLog> {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  Map<String, ConversationBox> conversationsMap = {};
  List<StreamSubscription<DatabaseEvent>> _subscriptions = [];

  @override
  void initState() {
    super.initState();
    _activeListeners();
  }

  void _activeListeners() {
    final groupSubscription = _database
        .child('users/${widget.uid}/chatgroup')
        .onValue
        .listen((event) {
      final value = event.snapshot.value;
      if (value is List<dynamic>) {
        print("value is List<dynamic>");
        // Convert the list to a List<String> if necessary
        final chatGroupIds = List<String>.from(value);
        chatGroupIds.forEach((cid) {
          final chatSubscription =
              _database.child('chats/$cid').onValue.listen((event) {
            final conversationData = event.snapshot.value;
            if (conversationData is Map<dynamic, dynamic>) {
              print("conversationData is Map<dynamic, dynamic>");
              try {
                final conversationMap =
                    conversationData.cast<String, dynamic>();
                final conversation = ConversationBox.fromMap(conversationMap);
                setState(() {
                  conversationsMap[cid] = conversation;
                });
              } catch (e) {
                print("Error converting conversation data: $e");
              }
            }
          });
          _subscriptions.add(chatSubscription);
        });
      }
    });
    _subscriptions.add(groupSubscription);
  }

  @override
  void dispose() {
    // Cancel all subscriptions when the widget is disposed
    for (var subscription in _subscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ConversationBox> chatlogs = conversationsMap.values.toList();

    // Sorting logic applied here
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
        DateTime dateA = DateFormat("dd/MM/yyyy HH:mm:ss").parse(a.date);
        DateTime dateB = DateFormat("dd/MM/yyyy HH:mm:ss").parse(b.date);

        // Reverse the comparison to make newer dates come first
        return dateB.compareTo(dateA);
      }

      // 3. If "seen" values are both true, compare "date" values (newer dates should come first)
      if (seenComparison == 0 && a.seen) {
        DateTime dateA = DateFormat("dd/MM/yyyy HH:mm:ss").parse(a.date);
        DateTime dateB = DateFormat("dd/MM/yyyy HH:mm:ss").parse(b.date);

        // Reverse the comparison to make newer dates come first
        return dateB.compareTo(dateA);
      }

      return seenComparison;
    });

    return Scaffold(
      backgroundColor: ColorTheme.WhiteColor,
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "กล่องข้อความ",
              style: FontTheme.h4.copyWith(color: ColorTheme.primaryColor),
            ),
          ],
        ),
      ),
      body: chatlogs.isEmpty
          ? Center(
              child: Text('ไม่พบบทสนทนา',
                  style: TextStyle(fontSize: 18, color: Colors.black26)))
          : ListView.builder(
              itemCount: chatlogs.length,
              itemBuilder: (context, index) {
                if (widget.uid == chatlogs[index].user &&
                    !chatlogs[index].psychiatristchat) {
                  return ConversationBox(
                    name: chatlogs[index].anonymousvolunteername,
                    cid: chatlogs[index].cid,
                    uid: widget.uid,
                    user: chatlogs[index].user,
                    volunteer: chatlogs[index].volunteer,
                    complete: chatlogs[index].complete,
                    seen: chatlogs[index].seen,
                    lastmessage: chatlogs[index].lastmessage,
                    lastsender: chatlogs[index].lastsender,
                    anonymoususername: chatlogs[index].anonymoususername,
                    anonymousvolunteername:
                        chatlogs[index].anonymousvolunteername,
                    psychiatristchat: chatlogs[index].psychiatristchat,
                    // messages: [],
                    // mil: 0,
                    imageURL: "assets/avatar/md_11.png",
                    date: chatlogs[index].date,
                  );
                } else if (widget.uid == chatlogs[index].user &&
                    chatlogs[index].psychiatristchat) {
                  return ConversationBox(
                    name: "จิตแพทย์" + chatlogs[index].anonymousvolunteername,
                    cid: chatlogs[index].cid,
                    uid: widget.uid,
                    user: chatlogs[index].user,
                    volunteer: chatlogs[index].volunteer,
                    complete: chatlogs[index].complete,
                    seen: chatlogs[index].seen,
                    lastmessage: chatlogs[index].lastmessage,
                    lastsender: chatlogs[index].lastsender,
                    anonymoususername: chatlogs[index].anonymoususername,
                    anonymousvolunteername:
                        chatlogs[index].anonymousvolunteername,
                    psychiatristchat: chatlogs[index].psychiatristchat,
                    // messages: [],
                    // mil: 0,
                    imageURL: "assets/avatar/md_11.png",
                    date: chatlogs[index].date,
                  );
                } else if (widget.uid == chatlogs[index].volunteer &&
                    !chatlogs[index].psychiatristchat) {
                  return ConversationBox(
                    name: chatlogs[index].anonymoususername + "(อาสาสมัคร)",
                    cid: chatlogs[index].cid,
                    uid: widget.uid,
                    user: chatlogs[index].user,
                    volunteer: chatlogs[index].volunteer,
                    complete: chatlogs[index].complete,
                    seen: chatlogs[index].seen,
                    lastmessage: chatlogs[index].lastmessage,
                    lastsender: chatlogs[index].lastsender,
                    anonymoususername: chatlogs[index].anonymoususername,
                    anonymousvolunteername:
                        chatlogs[index].anonymousvolunteername,
                    psychiatristchat: chatlogs[index].psychiatristchat,
                    // messages: [],
                    // mil: 0,
                    imageURL: "assets/avatar/md_11.png",
                    date: chatlogs[index].date,
                  );
                } else if (widget.uid == chatlogs[index].volunteer &&
                    chatlogs[index].psychiatristchat) {
                  return ConversationBox(
                    name: chatlogs[index].anonymoususername + "(จิตแพทย์)",
                    cid: chatlogs[index].cid,
                    uid: widget.uid,
                    user: chatlogs[index].user,
                    volunteer: chatlogs[index].volunteer,
                    complete: chatlogs[index].complete,
                    seen: chatlogs[index].seen,
                    lastmessage: chatlogs[index].lastmessage,
                    lastsender: chatlogs[index].lastsender,
                    anonymoususername: chatlogs[index].anonymoususername,
                    anonymousvolunteername:
                        chatlogs[index].anonymousvolunteername,
                    psychiatristchat: chatlogs[index].psychiatristchat,
                    // messages: [],
                    // mil: 0,
                    imageURL: "assets/avatar/md_11.png",
                    date: chatlogs[index].date,
                  );
                } else {
                  return ConversationBox(
                    name: 'ช่องแชทน้อน',
                    cid: chatlogs[index].cid,
                    uid: widget.uid,
                    user: chatlogs[index].user,
                    volunteer: chatlogs[index].volunteer,
                    complete: chatlogs[index].complete,
                    seen: chatlogs[index].seen,
                    lastmessage: chatlogs[index].lastmessage,
                    lastsender: chatlogs[index].lastsender,
                    anonymoususername: chatlogs[index].anonymoususername,
                    anonymousvolunteername:
                        chatlogs[index].anonymousvolunteername,
                    psychiatristchat: chatlogs[index].psychiatristchat,
                    // messages: [],
                    // mil: 0,
                    imageURL: "assets/avatar/md_11.png",
                    date: chatlogs[index].date,
                  );
                }
              },
            ),
    );
  }
}
