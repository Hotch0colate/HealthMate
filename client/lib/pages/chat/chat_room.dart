import 'package:client/component/navigation.dart';
import 'package:client/pages/chat/detail_user.dart';
import 'package:client/services/ip_variable.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:client/Pages/chatlog.dart';
import 'package:client/theme/font.dart';
import 'package:client/theme/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() {
  runApp(ChatRoom(
    cid: '',
    uid: '',
    messages: [],
  ));
}

class ChatRoom extends StatefulWidget {
  final String cid;
  final String uid;
  final List<Map<String, dynamic>> messages;

  // ChatRoom({required this.cid, required this.uid, required this.messages});

  @override
  ChatRoomBody createState() => ChatRoomBody();

  ChatRoom({
    required this.cid,
    required this.uid,
    required this.messages,
  });
}

class ChatRoomBody extends State<ChatRoom> {
  TextEditingController _textEditingController = TextEditingController();
  // Key _streamBuilderKey = UniqueKey();
  // int previousMessageLength = 0;
  late ScrollController _scrollController;
  final _database = FirebaseDatabase.instance.reference();
  StreamController<List<Message>> _messageStreamController =
      StreamController<List<Message>>();

  @override
  void initState() {
    super.initState();

    _activeListeners();

    _scrollController = ScrollController();
    // Add this block to scroll to the bottom only if there are messages

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.messages.isNotEmpty) {
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _activeListeners() {
    _database
        .child('chats/' + widget.cid + '/messages')
        .onValue
        .listen((event) {
      var snapshotValue = event.snapshot.value;
      if (snapshotValue != null && snapshotValue is Map<dynamic, dynamic>) {
        Map<String, dynamic> snapshotMap =
            Map<String, dynamic>.from(snapshotValue);

        // ตัวอย่างการเข้าถึงข้อมูลใน messages
        dynamic messagesData = snapshotMap;
        if (messagesData != null) {
          try {
            Map<String, dynamic> messagesMap =
                Map<String, dynamic>.from(messagesData);
            List<Message> parsedMessages = messagesMap.values
                .map((message) =>
                    Message.fromMap(Map<String, dynamic>.from(message)))
                .toList();

            _messageStreamController.add(parsedMessages);
          } catch (e) {
            print('Error processing messages data: $e');
          }
        } else {
          print('No messages found');
        }
      } else {
        print('Invalid snapshot value or format chatroom AYO');
      }
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    _messageStreamController.close();

    super.dispose();
  }

  Future<void> sendMessage(String text) async {
    try {
      final response = await http.post(
        Uri.parse('http://${fixedIp}:3000/chatroom/create_data'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'cid': widget.cid,
          'sender': widget.uid,
          'text': text,
        }),
      );

      if (response.statusCode == 200) {
        print('Message sent successfully');
      } else {
        print('Error sending message: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error sending message: $error');
    }
  }

  void onBackPress(BuildContext context) {
    Navigator.popUntil(context, (route) {
      if (route.settings.name == '/main') {
        // Assuming the MainApp route is the root ('/')
        final state = mainAppKey.currentState;
        if (state != null) {
          state.goToChatLog();
        }
        return true;
      }
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64.0),
        child: AppBar(
          backgroundColor: ColorTheme.primaryColor,
          elevation: 10.0,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(48.0),
              bottomRight: Radius.circular(48.0),
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              CupertinoIcons.back,
              size: 35,
            ),
            color: Colors.white,
            onPressed: () {
              onBackPress(context);
              // Navigator.pop(context, true);
            },
          ),
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailUserPage(), // Replace NextPage() with the actual page you want to navigate to
                        ),
                      );
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar/md_11.png'),
                ),
              ),
              const SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Volunteer A25',
                    style: FontTheme.subtitle2
                        .copyWith(color: ColorTheme.WhiteColor),
                  ),
                ],
              ),
              const SizedBox(width: 4.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorTheme
                      .successAction, // Use the appropriate color for online
                ),
              ),
              const Expanded(
                child: SizedBox(), // Spacer
              ),
              IconButton(
                onPressed: () {
                  //call page
                },
                icon: Icon(
                  CupertinoIcons.phone_fill,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                StreamBuilder<List<Message>>(
                  stream: _messageStreamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        snapshot.data == null) {
                      return
                          // const CircularProgressIndicator();
                          Container(
                        color: Colors.white,
                        child: const Center(
                          child: Text('ยังไม่มีข้อความในแชท',
                              style: FontTheme.body1),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      List<Message> messages = snapshot.data ?? [];
                      messages.sort((a, b) {
                        return a.date.compareTo(b.date);
                      });

                      _scrollToBottom();

                      return SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              for (int index = 0;
                                  index < messages.length;
                                  index++)
                                Column(
                                  crossAxisAlignment:
                                      (messages[index].sender != widget.uid
                                          ? CrossAxisAlignment.start
                                          : CrossAxisAlignment.end),
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 14,
                                          right: 14,
                                          top: 10,
                                          bottom: 10),
                                      child: ConstrainedBox(
                                        constraints:
                                            const BoxConstraints(maxWidth: 300),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: (messages[index].sender !=
                                                    widget.uid
                                                ? Colors.grey.shade200
                                                : ColorTheme.primaryColor),
                                          ),
                                          padding: const EdgeInsets.all(16),
                                          child: Text(
                                            messages[index].text,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: (messages[index].sender !=
                                                      widget.uid
                                                  ? Colors.black
                                                  : Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, bottom: 10),
                                      child: Text(
                                        DateFormat("HH:mm").format(
                                          DateFormat("dd/MM/yyyy HH:mm:ss")
                                              .parse(messages[index].date),
                                        ),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ],
                          ));
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(221, 255, 255, 255),
              border: Border.all(color: const Color.fromARGB(81, 34, 33, 33)),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            height: 80,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 30,
                    width: 30,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: "Type here ...",
                      hintStyle: TextStyle(
                        color: Color.fromARGB(98, 34, 33, 33),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    sendMessage(_textEditingController.text);
                    _textEditingController.clear();
                  },
                  elevation: 0,
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.send,
                    size: 30,
                    color: ColorTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final String sender;
  final String date;
  final String mid;
  final int mil;
  final bool seen;

  Message(
      {required this.text,
      required this.sender,
      required this.date,
      required this.mid,
      required this.mil,
      required this.seen});

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
        text: map['text'],
        sender: map['sender'],
        date: map['date'],
        mid: map['mid'],
        mil: map['mil'],
        seen: map['seen']);
  }
}
