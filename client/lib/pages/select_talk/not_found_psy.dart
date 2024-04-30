import 'package:client/component/buttons.dart';
import 'package:client/pages/select_talk/create_tag_page_psy.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotFoundPsy(),
    );
  }
}

class NotFoundPsy extends StatefulWidget {
  const NotFoundPsy({super.key});

  @override
  State<NotFoundPsy> createState() => _NotFoundPsyState();
}

class _NotFoundPsyState extends State<NotFoundPsy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.WhiteColor,
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 255, 253, 247)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/psychiatrist_glasses_not_found.png',
                height: 200,
              ),
              SizedBox(height: 20),
              Text(
                'ขออภัยครับ',
                style: FontTheme.body1,
              ),
              Text(
                'ไม่พบจิตแพทย์เลยย',
                style:
                    FontTheme.subtitle2.copyWith(color: ColorTheme.errorAction),
              ),
              SizedBox(height: 50,),
              MdPrimaryButton(text: 'กลับไปยังหน้าเลือกหัวข้อ', onPressed: () {
                    //เปลี่ยน flow ตรงนี้ ตั้งเพื่อทดสอบการรันเฉยๆ
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateTagPsyPage()),
                    );
                  },)
            ],
          ),
        ),
      ),
    );
  }
}
