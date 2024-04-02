import 'package:client/pages/emotion_calendar/calendar.dart';
import 'package:client/pages/psychiar_register/register.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthMate',
      home: FinishRegisterPsy(),
    );
  }
}

class FinishRegisterPsy extends StatefulWidget {
  const FinishRegisterPsy({super.key});

  @override
  State<FinishRegisterPsy> createState() => _FinishRegisterPsyState();
}

class _FinishRegisterPsyState extends State<FinishRegisterPsy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center content horizontally
              children: [
                Image.asset(
                  'assets/psy/finish_register_psy.png',
                  width: 250,
                ),
                Text(
                  'ยินดีด้วยครับ',
                  style: FontTheme.h3.copyWith(color: ColorTheme.baseColor),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'คุณเป็นจิตแพทย์ของ ',
                        style: FontTheme.body2.copyWith(
                          color: ColorTheme.baseColor,
                        ),
                      ),
                      TextSpan(
                        text: 'Health',
                        style: FontTheme.body2.copyWith(
                          color: ColorTheme.secondaryColor,
                        ),
                      ),
                      TextSpan(
                        text: 'Mate',
                        style: FontTheme.body2.copyWith(
                          color: ColorTheme.primaryColor,
                        ),
                      ),
                      TextSpan(
                        text: ' แล้ว',
                        style: FontTheme.body2.copyWith(
                          color: ColorTheme.baseColor,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.forward_rounded,
                    color: ColorTheme.primaryColor,
                    size: 50,
                  ),
                  onPressed: () {
                    //เปลี่ยน flow ตรงนี้ ตั้งเพื่อทดสอบการรันเฉยๆ
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Calendar()),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
