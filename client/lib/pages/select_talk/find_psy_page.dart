import 'dart:async';
import 'dart:convert';

import 'package:client/Pages/chat/chat_room.dart';
import 'package:client/component/dialog.dart';
import 'package:client/models/volunteer_response.dart';
import 'package:client/pages/select_talk/create_tag_page_psy.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/services/ip_variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import 'package:client/component/buttons.dart';
import 'package:client/component/navigation.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

class FindPsyPage extends StatelessWidget {
  final String selectedTag;
  final String text;

  const FindPsyPage({Key? key, required this.selectedTag, required this.text})
      : super(key: key);

  Future<VolunteerQueryResponse?> findPsychiatrist() async {
    await Future.delayed(Duration(seconds: 3));
    try {
      final result = await _tagMatchQuery(selectedTag);
      // Do something with result if needed
      return result;
    } catch (error) {
      print('Error finding volunteer: $error');
      // You may want to handle the error state differently,
      // such as returning null or indicating an error to the user.
      return null;
    }
  }

  Future<VolunteerQueryResponse> _tagMatchQuery(String tag) async {
    try {
      var _auth_service = AuthService();
      String? token = await _auth_service.getIdToken();

      final response = await http.post(
        Uri.parse('http://${fixedIp}:3000/psychiatrist/query_data'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"tags": tag}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return VolunteerQueryResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load psychiatrists');
      }
    } catch (error) {
      throw Exception('Failed to load psychiatrists: $error');
    }
  }

  Future<void> _CreateChatRoomAndSendFirstMessage(
      BuildContext context, String psychiatristUid) async {
    try {
      var _auth_service = AuthService();
      String? token = await _auth_service.getIdToken();

      final response = await http.post(
        Uri.parse('http://${fixedIp}:3000/chatlog/create_data'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(
            {"volunteer": psychiatristUid, "psychiatristchat": true}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        String cid = jsonResponse['Data'];
        String userUid = jsonResponse['userUid'];
        String volunteerUid = jsonResponse['volunteerUid'];
        String anonymousUserName = jsonResponse['anonymoususername'];
        String anonymousVolunteerName = jsonResponse['anonymousvolunteername'];
        bool psychiatristChat = jsonResponse['psychiatristchat'];

        if (cid != null) {
          String? token = await _auth_service.getIdToken();
          String uid = await fetchUidFromToken(token);
          print('cid reached');

          if (text != "") {
            print('text field reached');
            final _response = await http.post(
              Uri.parse('http://${fixedIp}:3000/chatroom/create_data'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode({"cid": cid, "text": text, "sender": uid}),
            );

            if (_response.statusCode != 200) {
              throw Exception('Fail to sent messages');
            } else {
              print('text sent');
            }
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatRoom(
                  cid: cid,
                  uid: uid,
                  messages: [],
                  userUid: userUid,
                  volunteerUid: volunteerUid,
                  anonUserName: anonymousUserName,
                  anonVolunteerName: anonymousVolunteerName,
                  psychiatristChat: psychiatristChat),
            ),
          );
        } else {
          throw Exception('CID not found in response');
        }
      } else {
        throw Exception('Failed to load volunteers');
      }
    } catch (error) {
      throw Exception('Failed to load volunteers: $error');
    }
  }

  Future<String> fetchUidFromToken(String? token) async {
    final response = await http.get(
      Uri.parse(
          'http://${fixedIp}:3000/access/get_uid'), // แทนที่ด้วย URL จริงของ backend ของคุณ
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // ส่ง token ใน header
      },
    );
    if (response.statusCode == 200) {
      // หาก server ตอบกลับมาด้วยสถานะ 200 OK, ดึง uid จาก response
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse['uid']; // ตัวอย่างการดึง uid จาก response
    } else {
      // หากการตอบกลับไม่สำเร็จ, โยน exception
      throw Exception('Failed to load uid from token, find psyhiatrist page');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.WhiteColor,
      appBar: AppBar(
        leading: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(CupertinoIcons.back)),
          ],
        ),
        toolbarHeight: 120,
      ),
      body: FutureBuilder(
        future: findPsychiatrist(), // Replace with your actual API call
        builder: (context, snapshot) {
          // While waiting for the API, show the animation and other content
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildWaitingContent();
          } else if (snapshot.hasError) {
            // If the Future completes with an error, show an error message
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // If we have data, use it to create a chatroom and send a message
            final data = snapshot.data;
            if (data != null) {
              // If the `findVolunteer` future is complete and has a volunteer UID, proceed to create chat room
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _CreateChatRoomAndSendFirstMessage(context, data.data!);
              });
            } else {
              return Center(child: Text('No data found inner'));
            }
            // Return a temporary placeholder widget if needed
            return Container();
          } else {
            // If no data and no error, you can show a default message
            return Center(child: Text('No data found outer'));
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MdPrimaryButton(
              onPressed: () {
                // Call the function to show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmDialogWithNoDetail(
                      title: 'ต้องการยกเลิกค้นหาใช่หรือไม่',
                      destination: CreateTagPsyPage(),
                    );
                  },
                );
              },
              text: 'ยกเลิก',
              backgroundColor: ColorTheme.errorAction,
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildWaitingContent() {
  // This method contains the content that's always visible, plus the AnimatedBackground
  return Center(
    child: Column(
      children: [
        // const SizedBox(
        //   height: 10,
        // ),
        Text(
          'กำลังค้นหา',
          style: FontTheme.h2.copyWith(color: ColorTheme.primaryColor),
        ),
        const SizedBox(
          height: 10,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            SpinKitFadingCircle(
              // FadingCircle loading animation
              size: 280, // Adjust size as needed
              color: ColorTheme.primaryColor,
              duration: Durations.extralong4,
            ), // This will display the animation
            Image.asset('assets/images/psychiatrist_glasses.png',
                width: 100,
                fit: BoxFit.contain), // This will stay static on top
          ],
        ),
        const SizedBox(
          height: 20,
        ),

        const SizedBox(
          height: 65,
        ),
      ],
    ),
  );
}

// class AnimatedBackground extends StatefulWidget {
//   const AnimatedBackground({Key? key}) : super(key: key);

//   @override
//   _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
// }

// class _AnimatedBackgroundState extends State<AnimatedBackground>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   late final List<Widget> _frames;
//   int _currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 1000), // Duration for each image
//       vsync: this,
//     )..addListener(() {
//         final newIndex = (_controller.value * _frames.length).floor();
//         if (newIndex != _currentIndex) {
//           setState(() {
//             _currentIndex = newIndex;
//           });
//         }
//       });

//     _controller.repeat(reverse: false); // Do not reverse the animation

//     _frames = [
//       Image.asset('assets/loading_screen/loading_1.png',
//           width: 300, fit: BoxFit.contain),
//       Image.asset('assets/loading_screen/loading_2.png',
//           width: 300, fit: BoxFit.contain),
//       Image.asset('assets/loading_screen/loading_3.png',
//           width: 300, fit: BoxFit.contain),
//       Image.asset('assets/loading_screen/loading_4.png',
//           width: 300, fit: BoxFit.contain),
//     ];
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSwitcher(
//       duration:
//           const Duration(milliseconds: 2500), // Duration of fade between images
//       child: _frames[_currentIndex % _frames.length],
//       transitionBuilder: (Widget child, Animation<double> animation) {
//         return FadeTransition(opacity: animation, child: child);
//       },
//     );
//   }
// }
