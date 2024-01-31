import 'package:flutter/material.dart';
import 'package:client/models/ChatUsers.dart';
import 'package:client/component/conversationList.dart';


void main() {
  runApp(ChatPage());
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

  List<ChatUsers> chatUsers = [
    ChatUsers(name: "Volunteer A25", messageText: "เป็นไงบ้าง", imageURL: "####", time: "ตอนนี้",),
    ChatUsers(name: "Volunteer A23", messageText: "สบายดีค่ะ", imageURL: "####", time: "10:00"),
    ChatUsers(name: "Volunteer A24", messageText: "สบายดีไหม", imageURL: "####", time: "เมื่อวาน"),
    ChatUsers(name: "Volunteer A21", messageText: "พักผ่อนเยอะๆ", imageURL: "####", time: "28 มกราคม"),
  ];

class _ChatPageState extends State<ChatPage> {
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
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ConversationList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messageText,
                  imageURL: chatUsers[index].imageURL,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
