import 'package:client/Pages/emotion_calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:client/services/auth_service.dart';
import 'package:client/services/ip_variable.dart';

import 'package:client/theme/color.dart';

import 'package:client/Pages/select_talk/talk_page.dart';
import 'package:client/pages/profile/profile.dart';
import 'package:client/pages/chat/chat_log.dart';

void main() => runApp(MainApp(SelectedPage: 0));

class MainApp extends StatefulWidget {
  int SelectedPage;

  MainApp({super.key, required this.SelectedPage});
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
    // print("TOKEN!!!!! $token");
    // ส่ง token ไปยัง backend เพื่อดึง uid
    String uid = await fetchUidFromToken(token);
    setState(() {
      userUid = uid; // อัปเดต uid ใน state
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
      throw Exception('Failed to load uid from token');
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
            Icons.calendar_month,
            size: 35,
          ),
          label: 'อารมณ์',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.people,
            size: 35,
          ),
          label: 'ปรึกษา',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.message,
            size: 35,
          ),
          label: 'ข้อความ',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            size: 35,
          ),
          label: 'โปรไฟล์',
        ),
      ],
    );
  }
}
