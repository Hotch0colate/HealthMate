import 'package:flutter/material.dart';
import 'package:client/theme/theme.dart';

import 'package:client/services/auth_service.dart';
import 'package:client/Pages/calendar.dart';
import 'package:client/Pages/select_talk.dart';
import 'package:client/Pages/profile.dart';
import 'package:client/Pages/chat_log.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:client/services/ip_variable.dart';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedPage = 0;
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
    print("TOKEN!!!!! $token");
    // ส่ง token ไปยัง backend เพื่อดึง uid
    String uid = await fetchUidFromToken(token);
    setState(() {
      userUid = uid; // อัปเดต uid ใน state
      print("set state complete");
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
      print("Success api shoot");
      print(jsonResponse['uid']);
      return jsonResponse['uid']; // ตัวอย่างการดึง uid จาก response
    } else {
      // หากการตอบกลับไม่สำเร็จ, โยน exception
      print("Not success api shoot");
      throw Exception('Failed to load uid from token');
    }
  }

  List<Widget> _pageOptions() => [
        Calendar(),
        SelectTalk(),
        ChatLog(uid: userUid), // ใช้ userUid ที่อัปเดตแล้ว
        ProfilePage(),
      ];

  @override
  Widget build(BuildContext context) {
    final pages = _pageOptions();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Navigation Bar Demo',
      home: Scaffold(
        body: pages[_selectedPage],
        bottomNavigationBar: BottomNavigationBarApp(
          selectedIndex: _selectedPage,
          onItemTapped: (index) {
            setState(() {
              _selectedPage = index;
            });
          },
        ),
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
      selectedItemColor: ColorTheme.primaryColor,
      unselectedItemColor: Colors.grey,
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
