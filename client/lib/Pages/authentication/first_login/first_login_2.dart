import 'package:client/component/text_field/date_picker.dart';
import 'package:client/services/ip_variable.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:client/services/auth_service.dart';
import 'package:intl/intl.dart';

import 'package:client/pages/authentication/first_login/first_login_1.dart';
import 'package:client/pages/authentication/first_login/first_login_3.dart';
import '../../../component/buttons.dart';

class FirstLogin2 extends StatefulWidget {
  const FirstLogin2({Key? key}) : super(key: key);

  @override
  _FirstLogin2State createState() => _FirstLogin2State();
}

class _FirstLogin2State extends State<FirstLogin2> {
  bool agreedToTerms = false;
  String selectedGender = '';

  Future<void> sendUserDataToBackend() async {
    var _auth_service = AuthService();
    String? token = await _auth_service.getIdToken();
    var url = Uri.parse('http://${fixedIp}:3000/user/update_data');
    var response = await http.post(
      url,
      body: json.encode({'birthday': birthDateController.text}),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print("Data submitted successfully");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FirstLogin3(),
        ),
      );
    } else {
      print("Failed to submit data: ${response.body}");
    }
  }

  DateTime? selectedDate;
  TextEditingController birthDateController = TextEditingController();

//เฟิร์น-ไม่เข้าใจเรื่องการเก็บวันเดือนปีจาก cuperdatepicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthDateController.text =
            DateFormat('dd/MM/yyyy').format(selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 32,
                ),
                Image.asset('assets/logos/big_app_name.png'),
                const SizedBox(height: 24),
                const SizedBox(
                  height: 72,
                  child: Image(
                    image: AssetImage('assets/logos/main_mascot.png'),
                  ),
                ),
                const SizedBox(height: 18),
                Text('คุณเกิดวันที่เท่าไหร่ครับ ?',
                    style: FontTheme.subtitle1
                        .copyWith(color: ColorTheme.primaryColor)),
                const SizedBox(height: 24),
                Text('คำตอบของคุณ: ', style: FontTheme.body1),
                const SizedBox(height: 12),
                CupertinoDatePickerField(
                  controller: birthDateController,
                  hintText: 'เลือกวันเกิดของคุณ',
                  labelText: '',
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 50, left: 27, right: 27),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GoBackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FirstLogin1(),
                  ),
                );
              },
            ),
            ForwardButton(
              onPressed: () {
                sendUserDataToBackend();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FirstLogin3()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
