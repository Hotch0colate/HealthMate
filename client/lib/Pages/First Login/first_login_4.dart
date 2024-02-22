import 'package:client/Pages/First%20Login/first_login_3.dart';
import 'package:client/Pages/First%20Login/first_login_5.dart';
import 'package:client/Pages/login.dart';
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
    var url = Uri.parse('http://localhost:3000/user/update_data'); // Replace with your backend endpoint
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
              const Text(
                '"Take deep breaths and release stress."',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins'),
              ),
              const SizedBox(
                height: 37,
              ),
              const SizedBox(
                height: 86,
                child: Image(
                  image: AssetImage(
                    'assets/main_mascot.png',
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
                    Container(
                      padding: const EdgeInsets.only(top: 0, bottom: 0),
                      child: ListTile(
                        dense: true, // Set dense property
                        title: const Text(
                          'โสด',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        leading: Radio<String>(
                          value: 'single',
                          groupValue: selectedMartial,
                          onChanged: (String? value) {
                            setState(() {
                              selectedMartial = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    ListTile(
                      dense: true, // Set dense property
                      title: const Text(
                        'มีแฟนแล้ว',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'partnered',
                        groupValue: selectedMartial,
                        onChanged: (String? value) {
                          setState(() {
                            selectedMartial = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      dense: true, // Set dense property
                      title: const Text(
                        'หมั้นแล้ว / แต่งงานแล้ว',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'married',
                        groupValue: selectedMartial,
                        onChanged: (String? value) {
                          setState(() {
                            selectedMartial = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      dense: true, // Set dense property
                      title: const Text(
                        'ม่าย / หย่าร้าง / แยกกันอยู่',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'divorced',
                        groupValue: selectedMartial,
                        onChanged: (String? value) {
                          setState(() {
                            selectedMartial = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      dense: true, // Set dense property
                      title: const Text(
                        'อยู่ในความสัมพันธ์แบบไม่ผูกมัด',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'non-binding relationship',
                        groupValue: selectedMartial,
                        onChanged: (String? value) {
                          setState(() {
                            selectedMartial = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      dense: true, // Set dense property
                      title: const Text(
                        'ค่อนข้างอธิบายยาก',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'complicated',
                        groupValue: selectedMartial,
                        onChanged: (String? value) {
                          setState(() {
                            selectedMartial = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press for the left button
                      // You can add your logic or navigation here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FirstLogin3(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: const Color.fromRGBO(34, 33, 33, 0.4),
                      side: const BorderSide(
                        color: Color.fromRGBO(34, 33, 33, 0.4),
                      ),
                    ),
                    child: const SizedBox(
                      height: 40,
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 28,
                            width: 28,
                            child: Image(
                              image: AssetImage('icons/goback.png'),
                            ),
                          ),
                          Text(
                            'ก่อนหน้า',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // You can customize the order of Image and Text based on your preference
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
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
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.orange),
                    ),
                    child: const SizedBox(
                      height: 40,
                      width: 118,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ต่อไป',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 28,
                            width: 28,
                            child: Image(
                              image: AssetImage('icons/foward.png'),
                            ),
                          ),
                          // You can customize the order of Image and Text based on your preference
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
