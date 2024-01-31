import 'package:client/theme/font.dart';
import 'package:client/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class ChatRoom extends StatefulWidget {
  final String cid;
  final String uid;
  final List<Map<String, dynamic>> messages;

  ChatRoom({required this.cid, required this.uid, required this.messages});

  @override
  ChatRoomBody createState() => ChatRoomBody();
}

class ChatRoomBody extends State<ChatRoom> {
  late Timer _apiCallTimer;
  TextEditingController _textEditingController = TextEditingController();
  Key _streamBuilderKey = UniqueKey();
  StreamController<Map<String, dynamic>> _messageStreamController =
      StreamController<Map<String, dynamic>>();
  int previousMessageLength = 0;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _apiCallTimer = Timer.periodic(Duration(milliseconds: 50), (Timer timer) {
      fetchAndCompareMessageLength();
    });

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
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _apiCallTimer.cancel();
    _textEditingController.dispose();
    _messageStreamController.close();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollToBottom();
    });
    super.dispose();
  }

  Future<void> fetchAndCompareMessageLength() async {
    Map<String, dynamic> messagesData = await fetchMessages();
    List<Map<String, dynamic>> messages =
        (messagesData["Data"] as List<dynamic>? ?? [])
            .cast<Map<String, dynamic>>();
    int currentMessageLength = messages.length;

    if (currentMessageLength != previousMessageLength) {
      await fetchMessages().then((messages) {
        previousMessageLength = currentMessageLength;
        _messageStreamController.add(messages);
        _messageStreamController.stream.listen((messages) {
          // คอยรอจนกว่า add จะเสร็จ
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            _scrollToBottom();
          });
        }).onDone(() {
          // Do something when the stream is closed
          _scrollToBottom(); // เลื่อนไปที่ข้อความล่าสุด
        });
      });
    }
  }

  Future<Map<String, dynamic>> fetchMessages() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/chatroom/read_data'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'cid': widget.cid}),
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

  Future<void> sendMessage(String text) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/chatroom/create_data'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: ColorTheme.primaryColor,
          elevation: 10.0,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/av1.png'),
              ),
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Volunteer A25',
                    style: FontTheme.h4,
                  ),
                ],
              ),
              SizedBox(
                  width:
                      10.0), // Add some spacing between the name and online status
              // Online status indicator (you can customize the color and shape)
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorTheme
                      .successAction, // Use the appropriate color for online
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.call,
                size: 35,
              ),
              color: Colors.white,
              onPressed: () {},
              // Navigate to Voice Call Page
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                StreamBuilder<Map<String, dynamic>>(
                  stream: _messageStreamController.stream,
                  key: _streamBuilderKey,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (snapshot.data?["RespCode"] != 200) {
                      return Text("Error: ${snapshot.data?["RespMessage"]}");
                    } else {
                      List<dynamic> messages = snapshot.data?["Data"] ?? [];
                      messages.sort((a, b) {
                        DateTime dateA =
                            DateFormat("dd/MM/yyyy HH:mm:ss").parse(a["date"]);
                        DateTime dateB =
                            DateFormat("dd/MM/yyyy HH:mm:ss").parse(b["date"]);
                        return dateA.compareTo(dateB);
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
                                      (messages[index]["sender"] != widget.uid
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
                                            color: (messages[index]["sender"] !=
                                                    widget.uid
                                                ? Colors.grey.shade200
                                                : ColorTheme.primaryColor),
                                          ),
                                          padding: const EdgeInsets.all(16),
                                          child: Text(
                                            messages[index]["text"],
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: (messages[index]
                                                          ["sender"] !=
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
                                              .parse(messages[index]["date"]),
                                        ),
                                        style: TextStyle(
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

          // Align(
          //   alignment: Alignment.bottomLeft,
          //   child: Container(
          //     decoration: BoxDecoration(
          //         color: const Color.fromARGB(221, 255, 255, 255),
          //         border:
          //             Border.all(color: const Color.fromARGB(81, 34, 33, 33)),
          //         borderRadius: const BorderRadius.only(
          //           topLeft: Radius.circular(20.0),
          //           topRight: Radius.circular(20.0),
          //         )),
          //     padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
          //     height: 80,
          //     width: double.infinity,
          //     child: Row(
          //       children: <Widget>[
          //         GestureDetector(
          //           onTap: () {},
          //           child: Container(
          //             height: 30,
          //             width: 30,
          //           ),
          //         ),
          //         const SizedBox(
          //           width: 15,
          //         ),
          //         Expanded(
          //           child: TextField(
          //             controller: _textEditingController,
          //             decoration: InputDecoration(
          //                 hintText: "Type here ...",
          //                 hintStyle:
          //                     TextStyle(color: Color.fromARGB(98, 34, 33, 33)),
          //                 border: InputBorder.none),
          //           ),
          //         ),
          //         FloatingActionButton(
          //           onPressed: () {
          //             sendMessage(_textEditingController.text);
          //             _textEditingController.clear();
          //           },
          //           elevation: 0,
          //           backgroundColor: Colors.white,
          //           child: const Icon(
          //             Icons.send,
          //             size: 30,
          //             color: ColorTheme.primaryColor,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
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
                    decoration: InputDecoration(
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
