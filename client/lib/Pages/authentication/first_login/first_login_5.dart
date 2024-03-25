import 'package:client/component/buttons.dart';
import 'package:client/component/select_box.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

//page import
import 'package:client/pages/authentication/first_login/first_login_4.dart';

//component import
import 'package:client/component/navigation.dart';

class FirstLogin5 extends StatefulWidget {
  const FirstLogin5({Key? key});

  @override
  _FirstLogin5State createState() => _FirstLogin5State();
}

class _FirstLogin5State extends State<FirstLogin5> {
  bool agreedToTerms = false;
  String acceptedTermValue = ''; // Variable to store selected gender
  String? acceptedTerm;

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
                width: MediaQuery.of(context).size.width - 32,
              ),
              Image.asset('assets/logos/big_app_name.png'),

              const SizedBox(
                height: 24,
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
              Text(
                  'ขอบคุณสำหรับการให้ข้อมูลนะครับ\nข้อมูลต่างๆ สามารแก้ไขได้ภายหลัง',
                  style:
                      FontTheme.body1.copyWith(color: ColorTheme.primaryColor)),
              const SizedBox(height: 24),
              Text(
                'คำตอบของคุณ: ',
                style: FontTheme.body1,
              ),
              // Radio buttons for gender selection
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.only(left: 35),
                child: Column(
                  children: [
                    ColorChangingRadio(
                      text: 'รับทราบ',
                      value: 'allow',
                      groupValue: acceptedTermValue,
                      onChanged: (String? value) {
                        setState(() {
                          acceptedTerm = value;
                          acceptedTermValue = value!;
                        });
                      },
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
            GoBackButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FirstLogin4(),
                ),
              );
            }),
            MdPrimaryButton(
              text: 'ดำเนินการต่อ',
              onPressed: () {
                if (acceptedTermValue.isNotEmpty) {
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
                      content: Text("Please select accept"),
                    ),
                  );
                }
              },
              foregroundColor: Colors.white, // Change text color
              backgroundColor: ColorTheme.successAction,
              borderColor:
                  ColorTheme.successAction, // Change button background color
            ),
          ],
        ),
      ),
    );
  }
}
