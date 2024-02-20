import 'package:client/Pages/login.dart';
import 'package:flutter/material.dart';
import 'package:client/Pages/First%20Login/first_login_2.dart';

class FirstLogin1 extends StatefulWidget {
  const FirstLogin1({Key? key});

  @override
  _FirstLogin1State createState() => _FirstLogin1State();
}

class _FirstLogin1State extends State<FirstLogin1> {
  bool agreedToTerms = false;
  String selectedGender = ''; // Variable to store selected gender

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
                height: 111,
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
                'เพศของคุณคืออะไร ?',
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
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.only(left: 35),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('ชาย',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins')),
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
                      title: const Text('หญิง',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins')),
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
                      title: const Text('อื่นๆ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins')),
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
              ),
              const SizedBox(height: 60),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FirstLogin2(),
                      ),
                    );
                    // Handle button press for the left button
                    // You can add your logic or navigation here
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
