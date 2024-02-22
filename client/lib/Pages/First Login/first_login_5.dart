import 'package:client/Pages/First%20Login/first_login_4.dart';
import 'package:client/Pages/login.dart';
import 'package:client/component/navigation.dart';
import 'package:flutter/material.dart';

class FirstLogin5 extends StatefulWidget {
  const FirstLogin5({Key? key});

  @override
  _FirstLogin5State createState() => _FirstLogin5State();
}

class _FirstLogin5State extends State<FirstLogin5> {
  bool agreedToTerms = false;
  String selectedAllow = ''; // Variable to store selected gender

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
                'ขอบคุณสำหรับการให้ข้อมูลนะครับ',
                style: TextStyle(
                    color: Color.fromRGBO(251, 133, 0, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'),
              ),
              const Text(
                'ข้อมูลต่างๆ สามารแก้ไขได้ภายหลัง',
                style: TextStyle(
                    color: Color.fromRGBO(251, 133, 0, 1),
                    fontSize: 18,
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
                    ListTile(
                      dense: true, // Set dense property
                      title: const Text(
                        'รับทราบ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'Allow',
                        groupValue: selectedAllow,
                        onChanged: (String? value) {
                          setState(() {
                            selectedAllow = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 240),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (selectedAllow.isNotEmpty) {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainApp(),
                        ),
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
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: const Color.fromRGBO(72, 210, 104, 1),
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.orange),
                    ),
                    child: const SizedBox(
                      height: 40,
                      width: 137,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ดำเนินการต่อ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
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
