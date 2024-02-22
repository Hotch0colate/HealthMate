import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding

// Assuming this is the next page you want to navigate to after submitting gender
import 'package:client/Pages/First%20Login/first_login_2.dart';

class FirstLogin1 extends StatefulWidget {
  const FirstLogin1({Key? key}) : super(key: key);

  @override
  _FirstLogin1State createState() => _FirstLogin1State();
}

class _FirstLogin1State extends State<FirstLogin1> {
  bool agreedToTerms = false;
  String selectedGender = ''; // Variable to store selected gender

  // Function to submit the gender to the backend
  Future<void> submitGender(String gender) async {
    var url = Uri.parse('http://localhost:3000/user/update_data'); // Change to your actual endpoint
    var response = await http.post(url,
        body: json.encode({'gender': gender}),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // Handle successful request
      print("Gender submitted successfully");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FirstLogin2(),
        ),
      );
    } else {
      // Handle error
      print("Failed to submit gender: ${response.body}");
    }
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
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'HEALTH',
                      style: TextStyle(
                        color: Color.fromRGBO(33, 150, 243, 1),
                        fontSize: 54,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'MATE',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 54,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 37),
              const Text(
                '"Take deep breaths and release stress."',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 86, child: Placeholder()), // Placeholder for an image
              const Text(
                'เพศของคุณคืออะไร ?',
                style: TextStyle(
                  color: Color.fromRGBO(251, 133, 0, 1),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 26.5),
              const Text(
                'คำตอบของคุณ: ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  ListTile(
                    title: const Text('ชาย'),
                    leading: Radio<String>(
                      value: 'Male',
                      groupValue: selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('หญิง'),
                    leading: Radio<String>(
                      value: 'Female',
                      groupValue: selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('อื่นๆ'),
                    leading: Radio<String>(
                      value: 'Others',
                      groupValue: selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedGender.isNotEmpty) {
                      submitGender(selectedGender);
                    } else {
                      // Prompt user to select a gender or handle this case accordingly
                      print("Please select a gender");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange, // background (deprecated, use backgroundColor)
                    onPrimary: Colors.white, // foreground (deprecated, use foregroundColor)
                  ),
                  child: const Text('ต่อไป'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
