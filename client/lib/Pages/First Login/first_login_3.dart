import 'package:client/Pages/First%20Login/first_login_4.dart';
import 'package:client/Pages/login.dart';
import 'package:flutter/material.dart';
import 'package:client/Pages/First%20Login/first_login_2.dart';

class FirstLogin3 extends StatefulWidget {
  const FirstLogin3({Key? key}) : super(key: key);

  @override
  _FirstLogin3State createState() => _FirstLogin3State();
}

class _FirstLogin3State extends State<FirstLogin3> {
  bool agreedToTerms = false;
  String selectedGender = ''; // Variable to store selected gender
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 37),
              const SizedBox(
                height: 86,
                child: Image(
                  image: AssetImage('../../../assets/logos/main_mascot.png'),
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
                      value: 'นักเรียน/นิสิตนักศึกษา',
                    ),
                    _buildRadioListTile(
                      title: 'พนักงานบริษัทเอกชน',
                      value: 'พนักงานบริษัทเอกชน',
                    ),
                    _buildRadioListTile(
                      title: 'พนักงานข้าราชการ',
                      value: 'พนักงานข้าราชการ',
                    ),
                    _buildRadioListTile(
                      title: 'พนักงานรัฐวิสาหกิจ',
                      value: 'พนักงานรัฐวิสาหกิจ',
                    ),
                    _buildRadioListTile(
                      title: 'พนักงานโรงงานอุตสาหกรรม',
                      value: 'พนักงานโรงงานอุตสาหกรรม',
                    ),
                    _buildRadioListTile(
                      title: 'เจ้าของธุรกิจ/ธุรกิจส่วนตัว',
                      value: 'เจ้าของธุรกิจ/ธุรกิจส่วนตัว',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
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
                          builder: (context) => const FirstLogin2(),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FirstLogin4(),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
