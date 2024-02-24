import 'package:client/Pages/First%20Login/first_login_3.dart';
import 'package:client/Pages/First%20Login/first_login_5.dart';
import 'package:client/Pages/login.dart';
import 'package:client/component/buttons.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For using json.encode

class FirstLogin4 extends StatefulWidget {
  const FirstLogin4({Key? key});

  @override
  _FirstLogin4State createState() => _FirstLogin4State();
}

class _FirstLogin4State extends State<FirstLogin4> {
  bool agreedToTerms = false;
  String selectedMartial = ''; // Variable to store selected gender

  Future<void> sendDataToBackend(String occupation) async {
    var url = Uri.parse(
        'http://localhost:3000/user/update_data'); // Replace with your backend endpoint
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"occupation": occupation}),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, then navigate to the next page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FirstLogin5(),
        ),
      );
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  String? selectedJobRole;

  Widget _buildRadioListTile({required String title, required String value}) {
    return ListTile(
      dense: true,
      title: Text(
        title,
        style: TextStyle(
          color: selectedJobRole == value ? Colors.orange : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins',
        ),
      ),
      leading: Radio<String>(
        value: value,
        groupValue: selectedJobRole,
        onChanged: (String? value) {
          setState(() {
            selectedJobRole = value;
          });
        },
        activeColor: Colors.orange,
      ),
    );
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
                'ตอนนี้สถานะคุณคืออะไรครับ ?',
                style: TextStyle(
                    color: Color.fromRGBO(251, 133, 0, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 26.5),
              const Text(
                'คำตอบของคุณ: ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins'),
              ),
              // Radio buttons for gender selection
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.only(left: 35),
                child: Column(
                  children: [
                    _buildRadioListTile(
                      title: 'โสด',
                      value: 'single',
                    ),
                    _buildRadioListTile(
                      title: 'มีแฟนแล้ว',
                      value: 'partnered',
                    ),
                    _buildRadioListTile(
                      title: 'หมั้นแล้ว / แต่งงานแล้ว',
                      value: 'married',
                    ),
                    _buildRadioListTile(
                      title: 'ม่าย / หย่าร้าง / แยกกันอยู่',
                      value: 'divorced',
                    ),
                    _buildRadioListTile(
                      title: 'อยู่ในความสัมพันธ์แบบไม่ผูกมัด',
                      value: 'non-binding relationship',
                    ),
                    _buildRadioListTile(
                      title: 'ค่อนข้างอธิบายยาก',
                      value: 'complicated',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GoBackButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FirstLogin3(),
                      ),
                    );
                  }),
                  ForwardButton(onPressed: () {
                    if (selectedMartial.isNotEmpty) {
                      sendDataToBackend(selectedMartial);
                    } else {
                      // Show an alert or a snackbar message to select an occupation
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select an occupation"),
                        ),
                      );
                    }
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
