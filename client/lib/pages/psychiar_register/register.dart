import 'package:client/component/buttons.dart';
import 'package:client/component/navigation.dart';
import 'package:client/component/select_box.dart';
import 'package:client/pages/psychiar_register/attach_cert.dart';
import 'package:client/pages/select_talk/talk_page.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

class PsyRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons
                                      .arrow_back_ios, // Replace with your custom icon
                                  color: Colors.black38,
                                  size: 30, // Customize the icon color
                                ),
                                onPressed: () {
                                  //กลับไปหน้า Select talk
                                  //เปลี่ยน flow ตรงนี้ ตั้งเพื่อทดสอบการรันเฉยๆ
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MainApp(SelectedPage: 1)),
                                    (Route<dynamic> route) =>
                                        false, // Remove all routes below
                                  );
                                },
                              ),
                            ],
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'ลงทะเบียน',
                                  style: FontTheme.h4.copyWith(
                                      color: ColorTheme
                                          .baseColor), // Black color for the first part of the text
                                ),
                                TextSpan(
                                  text: 'จิตแพทย์',
                                  style: FontTheme.h4.copyWith(
                                      color: ColorTheme
                                          .secondaryColor), // Secondary color for the second part of the text
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Image.asset(
                            'assets/psy/psy_cat.png',
                            height: 120,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'ข้อตกลงการเป็นจิตแพทย์',
                            style: FontTheme.subtitle2,
                          ),
                          Image.asset(
                            'assets/logos/small_app_name.png',
                          ),
                          SizedBox(height: 20),
                          ColorChangingCheckbox(
                            key: UniqueKey(),
                            text:
                                'ข้าพเจ้าจะปฏิบัติหน้าที่อาสาสมัครอย่างเต็มที่',
                            onChanged: (bool value) {
                              // Callback when checkbox state changes
                              print('Checkbox state changed: $value');
                            },
                          ),
                          SizedBox(height: 10),
                          ColorChangingCheckbox(
                            key: UniqueKey(),
                            text:
                                'ข้าพเจ้าจะเก็บรักษาความลับของอีกฝ่าย\nอย่างเคร่งครัด',
                            onChanged: (bool value) {
                              // Callback when checkbox state changes
                              print('Checkbox state changed: $value');
                            },
                          ),
                          SizedBox(height: 10),
                          ColorChangingCheckbox(
                            key: UniqueKey(),
                            text:
                                'ข้าพเจ้าจะให้เกียรติอีกฝ่ายและให้คำปรึกษา\nแบบเชิงบวก',
                            onChanged: (bool value) {
                              // Callback when checkbox state changes
                              print('Checkbox state changed: $value');
                            },
                          ),
                          SizedBox(height: 50),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ForwardButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AttachCertificate()),
                                );
                              },
                            ),
                          ),
                        ])))));
  }
}
