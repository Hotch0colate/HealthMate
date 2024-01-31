import 'package:flutter/material.dart';
import 'package:client/component/conversationList.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:intl/intl.dart';

class ChatLog extends StatefulWidget {
  final String uid;

  ChatLog({required this.uid});

  @override
  _ChatLogState createState() => _ChatLogState();
}

// List<ChatUsers> chatUsers = [
//   ChatUsers(
//     name: "Volunteer A25",
//     messageText: "เป็นไงบ้าง",
//     imageURL: "####",
//     time: "ตอนนี้",
//   ),
//   ChatUsers(
//       name: "Volunteer A23",
//       messageText: "สบายดีค่ะ",
//       imageURL: "####",
//       time: "10:00"),
//   ChatUsers(
//       name: "Volunteer A24",
//       messageText: "สบายดีไหม",
//       imageURL: "####",
//       time: "เมื่อวาน"),
//   ChatUsers(
//       name: "Volunteer A21",
//       messageText: "พักผ่อนเยอะๆ",
//       imageURL: "####",
//       time: "28 มกราคม"),
// ];

class _ChatLogState extends State<ChatLog> {
  Key _streamBuilderKey = UniqueKey();
  StreamController<Map<String, dynamic>> _chatlogStreamController =
      StreamController<Map<String, dynamic>>();
  late Timer _apiCallTimer;
  int previousChatLogLength = 0;

  @override
  void initState() {
    super.initState();
    _apiCallTimer = Timer.periodic(Duration(milliseconds: 50), (Timer timer) {
      fetchAndCompareChatLength();
    });
  }

  @override
  void dispose() {
    _apiCallTimer.cancel();
    _chatlogStreamController.close();

    super.dispose();
  }

  Future<void> fetchAndCompareChatLength() async {
    Map<String, dynamic> chatsData = await fetchChats();
    List<Map<String, dynamic>> chats =
        (chatsData["Data"] as List<dynamic>? ?? [])
            .cast<Map<String, dynamic>>();
    int currentChatLogLength = chats.length;

    if (currentChatLogLength != previousChatLogLength) {
      await fetchChats().then((chats) {
        previousChatLogLength = currentChatLogLength;
        _chatlogStreamController.add(chats);
        // _chatlogStreamController.stream.listen((messages) {
        //   // คอยรอจนกว่า add จะเสร็จ
        //   WidgetsBinding.instance?.addPostFrameCallback((_) {
        //     _scrollToBottom();
        //   });
        // }).onDone(() {
        //   // Do something when the stream is closed
        //   _scrollToBottom(); // เลื่อนไปที่ข้อความล่าสุด
        // });
      });
    }
  }

  Future<Map<String, dynamic>> fetchChats() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/chatlog/read_data_all'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'uid': widget.uid}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          "RespCode": response.statusCode,
          "RespMessage": "Error: ${response.reasonPhrase}",
        };
      }
    } catch (error) {
      return {
        "RespCode": 500,
        "RespMessage": "Error: $error",
      };
    }
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
            StreamBuilder<Map<String, dynamic>>(
                stream: _chatlogStreamController.stream,
                key: _streamBuilderKey,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.data?["RespCode"] != 200) {
                    return Text("Error: ${snapshot.data?["RespMessage"]}");
                  } else {
                    List<dynamic> chatlogs = snapshot.data?["Data"] ?? [];
                    // chatlogs.sort((a, b) {
                    //   DateTime dateA =
                    //       DateFormat("dd/MM/yyyy HH:mm:ss").parse(a["date"]);
                    //   DateTime dateB =
                    //       DateFormat("dd/MM/yyyy HH:mm:ss").parse(b["date"]);
                    //   return dateA.compareTo(dateB);
                    // });

                    return ListView.builder(
                      itemCount: chatlogs.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ConversationBox(
                          name: "ช่องแชท",
                          cid: chatlogs[index]["cid"],
                          uid: widget.uid,
                          messageText: chatlogs[index]["lastmessage"],
                          imageURL: "###",
                          date: chatlogs[index]["date"],
                          seen: chatlogs[index]["seen"],
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
