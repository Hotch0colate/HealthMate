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
  late Future<Map<String, dynamic>> _fetchMessagesFuture;
  late Timer _apiCallTimer;
  TextEditingController _textEditingController = TextEditingController();
  Key _futureBuilderKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _fetchMessagesFuture = fetchMessages();
    _apiCallTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _futureBuilderKey = UniqueKey(); // ให้สร้าง FutureBuilder ใหม่
      });
    });
  }

  @override
  void dispose() {
    _apiCallTimer.cancel();
    _textEditingController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> fetchMessages() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.0.105:3000/chatroom/read_data'),
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
        Uri.parse('http://192.168.0.105:3000/chatroom/create_data'),
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
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: ColorTheme.primaryColor,
          elevation: 10.0,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(70.0),
              bottomRight: Radius.circular(70.0),
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
          title: const Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/av1.png'),
              ),
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'อาสาสมัคร A25',
                    style: FontTheme.h4,
                  ),
                ],
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
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          FutureBuilder<Map<String, dynamic>>(
            future: fetchMessages(),
            key: _futureBuilderKey,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (snapshot.data?["RespCode"] != 200) {
                return Text("Error: ${snapshot.data?["RespMessage"]}");
              } else {
                List<dynamic> messages = snapshot.data?["Data"] ?? [];
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment:
                          (messages[index]["sender"] != widget.uid
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end),
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 14, right: 14, top: 10, bottom: 10),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 300,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (messages[index]["sender"] != widget.uid
                                    ? Colors.grey.shade200
                                    : ColorTheme.primaryColor),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                messages[index]["text"],
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      (messages[index]["sender"] != widget.uid
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
                    );
                  },
                );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(221, 255, 255, 255),
                  border:
                      Border.all(color: const Color.fromARGB(81, 34, 33, 33)),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  )),
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 80,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                          hintText: "Type here ...",
                          hintStyle:
                              TextStyle(color: Color.fromARGB(98, 34, 33, 33)),
                          border: InputBorder.none),
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
          ),
        ],
      ),
    );
  }
}
