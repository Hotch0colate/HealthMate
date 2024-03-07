import 'package:client/pages/authentication/first_login/first_login_4.dart';
import 'package:client/component/buttons.dart';
import 'package:client/services/ip_variable.dart';
import 'package:flutter/material.dart';
import 'package:client/pages/authentication/first_login/first_login_2.dart';
import 'package:client/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For using json.encode

class FirstLogin3 extends StatefulWidget {
  const FirstLogin3({Key? key}) : super(key: key);

  @override
  _FirstLogin3State createState() => _FirstLogin3State();
}

class _FirstLogin3State extends State<FirstLogin3> {
  bool agreedToTerms = false;
  String selectedCareerValue = ''; // Changed variable name for clarity

  // Function to send data to backend
  Future<void> sendDataToBackend(String career) async {
    var _auth_service = AuthService();
    String? token = await _auth_service.getIdToken();

    var url = Uri.parse(
        'http://${fixedIp}:3000/user/update_data'); // Replace with your backend endpoint
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({"career": career}),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, then navigate to the next page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FirstLogin4(),
        ),
      );
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  String? selectedCareer;

  Widget _buildRadioListTile({required String title, required String value}) {
    return ListTile(
      dense: true,
      title: Text(
        title,
        style: TextStyle(
          color: selectedCareer == value ? Colors.orange : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins',
        ),
      ),
      leading: Radio<String>(
        value: value,
        groupValue: selectedCareer,
        onChanged: (String? value) {
          setState(() {
            selectedCareer = value;
            selectedCareerValue = value!;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 51,
                width: MediaQuery.of(context).size.width - 32,
              ),
              Image.asset('assets/logos/big_app_name.png'),
              const SizedBox(height: 37),
              const SizedBox(
                height: 86,
                child: Image(
                  image: AssetImage('assets/logos/main_mascot.png'),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'คุณทำงานอาชีพอะไรครับ ?',
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
                padding: const EdgeInsets.only(left: 35),
                child: Column(
                  children: <Widget>[
                    _buildRadioListTile(
                      title: 'นักเรียน/นิสิตนักศึกษา',
                      value: 'Student',
                    ),
                    _buildRadioListTile(
                      title: 'พนักงานบริษัทเอกชน',
                      value: 'OfficeWorker',
                    ),
                    _buildRadioListTile(
                      title: 'พนักงานข้าราชการ',
                      value: 'PublicServant',
                    ),
                    _buildRadioListTile(
                      title: 'พนักงานรัฐวิสาหกิจ',
                      value: 'StateEnterpriseEmployee',
                    ),
                    _buildRadioListTile(
                      title: 'พนักงานโรงงานอุตสาหกรรม',
                      value: 'IndustryWorker',
                    ),
                    _buildRadioListTile(
                      title: 'เจ้าของธุรกิจ/ธุรกิจส่วนตัว',
                      value: 'PrivateBusiness',
                    ),
                  ],
                ),
              ),
            ],
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
                // Your navigation or functionality here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const FirstLogin2(), // Example: Navigate to a specific screen
                  ),
                );
              },
            ),
            ForwardButton(
              onPressed: () {
                if (selectedCareerValue.isNotEmpty) {
                  sendDataToBackend(selectedCareerValue);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FirstLogin4()),
                  );
                } else {
                  // Show an alert or a snackbar message to select an occupation
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select an occupation"),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
