import 'package:client/services/ip_variable.dart';
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
                  height: 51,
                  width: MediaQuery.of(context).size.width - 32,
                ),
                Image.asset('assets/logos/big_app_name.png'),
                const SizedBox(
                  height: 37,
                ),
                const SizedBox(
                  height: 86,
                  child: Image(
                    image: AssetImage(
                      'assets/logos/main_mascot.png',
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'วันเกิดคุณคือวันไหนครับ ?',
                  style: TextStyle(
                    color: Color.fromRGBO(251, 133, 0, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 26.5),
                const Text(
                  'คำตอบของคุณ: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: TextFormField(
                    controller: birthDateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(34, 33, 33, 0.6),
                          width: 2,
                        ),
                      ),
                      hintText: 'DD/MM/YYYY',
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(34, 33, 33, 0.6),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context),
                        color: Color.fromRGBO(34, 33, 33, 0.6),
                      ),
                    ),
                    readOnly: true,
                  ),
                ),
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
