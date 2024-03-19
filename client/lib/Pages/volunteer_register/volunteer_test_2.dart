import 'package:client/Pages/volunteer_register/volunteer_test_1.dart';
import 'package:client/Pages/volunteer_register/volunteer_test_3.dart';
import 'package:client/component/buttons.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

class VolunteerTest2 extends StatefulWidget {
  const VolunteerTest2({Key? key});

  @override
  _VolunteerTest2State createState() => _VolunteerTest2State();
}

class _VolunteerTest2State extends State<VolunteerTest2> {
  int selectedIndex = -1;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 50, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: MediaQuery.of(context).size.width - 32,
                ),
                Text(
                  'แบบทดสอบอาสาสมัคร',
                  style: FontTheme.subtitle1.copyWith(color: Colors.black),
                ),
                Image.asset('assets/images/Volunteer hat.png'),
                SizedBox(height: screenHeight * 0.05),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.003),
                  child: Text(
                    'จากสถานการณ์ดังกล่าว พี่แอนควรปฏิบัติตนอย่างไร',
                    style: FontTheme.subtitle2
                        .copyWith(color: ColorTheme.primaryColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.01),
                  child: Text('คำตอบของคุณ :',
                      style: FontTheme.subtitle2.copyWith(color: Colors.black)),
                ),
                SizedBox(height: screenHeight * 0.01),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      borderSide: BorderSide(
                        color: ColorTheme.baseColor.withOpacity(0.4),
                      ),
                    ),
                  ),
                  maxLines: 4,
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
                    builder: (context) => const VolunteerTest1(),
                  ),
                );
              },
            ),
            ForwardButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VolunteerTest3(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
