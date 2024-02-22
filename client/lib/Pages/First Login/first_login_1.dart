import 'package:client/Pages/login.dart';
import 'package:client/component/buttons.dart';
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
                      title: Text('ชาย',
                          style: TextStyle(
                              color: selectedGender == 'Male'
                                  ? Colors.orange
                                  : Colors
                                      .black, // Change color based on selection
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
                        activeColor:
                            Colors.orange, // Set the active color to orange
                      ),
                    ),
                    ListTile(
                      title: Text('หญิง',
                          style: TextStyle(
                              color: selectedGender == 'Female'
                                  ? Colors.orange
                                  : Colors
                                      .black, // Change color based on selection
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
                        activeColor:
                            Colors.orange, // Set the active color to orange
                      ),
                    ),
                    ListTile(
                      title: Text('อื่นๆ',
                          style: TextStyle(
                              color: selectedGender == 'Others'
                                  ? Colors.orange
                                  : Colors
                                      .black, // Change color based on selection
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
                        activeColor:
                            Colors.orange, // Set the active color to orange
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 125),

              Align(
                alignment: Alignment.centerRight,
                child: ForwardButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FirstLogin2(),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
