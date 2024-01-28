import 'package:client/theme/font.dart';
import 'package:client/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:client/models/ChatMessage.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(Chatroom());
}

// data ใน HealthMate\client\lib\models\ChatMessage.dart
// ไม่แน่ใจเรื่องชื่อตัวแปรที่ตั้งกับข้อมูลในDB
class Chatroom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ChatroomBody(),
      ),
    );
  }
}

class ChatroomBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //top bar
        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(80.0), // Adjust the height as needed
          child: AppBar(
            backgroundColor: ColorTheme.primaryColor,
            elevation: 10.0, // Remove elevation if you don't want a shadow
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
                // Back to Chatlog page
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
                onPressed: (
                    //Navigate to Voice Call Page
                    ) {},
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            //show message
            ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: (messages[index].messageType == "receiver"
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end),
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 300, // Set maximum width
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (messages[index].messageType == "receiver"
                                ? Colors.grey.shade200
                                : ColorTheme.primaryColor),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            messages[index].messageContent,
                            style: TextStyle(
                              fontSize: 16,
                              color: (messages[index].messageType == "receiver"
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
                        DateFormat('HH:mm').format(messages[index].timestamp),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            //type box
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
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Type here ...",
                            hintStyle: TextStyle(color: Color.fromARGB(98, 34, 33, 33)),
                            border: InputBorder.none),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: (
                        //Send Message
                      ) {},
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
      ),
    );
  }
}


//FINISH BY FERN