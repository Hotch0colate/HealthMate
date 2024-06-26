import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:client/services/auth_service.dart';
import 'package:client/services/ip_variable.dart';

import 'package:client/theme/color.dart';

import 'package:client/pages/profile/profile.dart';
import 'package:client/pages/chat/chat_log.dart';
import 'package:client/Pages/emotion_calendar/calendar.dart';
import 'package:client/pages/select_talk/select_talk_page.dart';

void main() => runApp(MainApp(SelectedPage: 0));

GlobalKey<_MainAppState> mainAppKey = GlobalKey();

class MainApp extends StatefulWidget {
  int SelectedPage;

  MainApp({required this.SelectedPage}) : super(key: mainAppKey);
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String userUid = '';

  @override
  void initState() {
    super.initState();
    _fetchAndSetUid();
  }

  void _fetchAndSetUid() async {
    // สมมติว่าคุณมีฟังก์ชัน `getToken` ที่สามารถดึง token ของผู้ใช้
    var _auth_service = AuthService();
    String? token = await _auth_service
        .getIdToken(); // สมมติว่า getIdToken คืนค่า Future<String?>
    // print(token);
    // ส่ง token ไปยัง backend เพื่อดึง uid
    String uid = await fetchUidFromToken(token);
    // print(uid);
    setState(() {
      userUid = uid; // อัปเดต uid ใน state
    });
  }

  void goToChatLog() {
    setState(() {
      widget.SelectedPage = 2;
    });
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
      throw Exception('Failed to load uid from token, navigation page');
    }
  }

  List<Widget> _pageOptions() => [
        const Calendar(),
        TalkPage(),
        ChatLog(uid: userUid), // ใช้ userUid ที่อัปเดตแล้ว
        const ProfilePage(),
      ];

  @override
  Widget build(BuildContext context) {
    final pages = _pageOptions();

    return Scaffold(
      body: pages[widget.SelectedPage],
      bottomNavigationBar: BottomNavigationBarApp(
        selectedIndex: widget.SelectedPage,
        onItemTapped: (index) {
          setState(() {
            widget.SelectedPage = index;
          });
        },
      ),
    );
  }
}

class BottomNavigationBarApp extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  BottomNavigationBarApp({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      backgroundColor: ColorTheme.WhiteColor,
      selectedItemColor: ColorTheme.primaryColor,
      unselectedItemColor: Colors.black26,
      type: BottomNavigationBarType.fixed,
      onTap: onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calendar_today_rounded,
            size: 36,
          ),
          label: 'ปฏิทินอารมณ์',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.person_2_fill,
            size: 36,
          ),
          label: 'ปรึกษา',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.chat_bubble_fill,
            size: 36,
          ),
          label: 'แชท',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.person_fill,
            size: 36,
          ),
          label: 'โปรไฟล์',
        ),
      ],
    );
  }
}
