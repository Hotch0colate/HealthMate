import 'package:client/component/buttons.dart';
import 'package:client/component/text_field/text_field.dart';
import 'package:client/pages/psychiar/upload_image.dart';
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
      home: AttachCertificate(),
    );
  }
}

class AttachCertificate extends StatelessWidget {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
        child: Padding(
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
                          Icons.arrow_back_ios,
                          color: Colors.black38,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'ลงทะเบียน',
                          style: FontTheme.h4.copyWith(
                            color: ColorTheme.baseColor,
                          ),
                        ),
                        TextSpan(
                          text: 'จิตแพทย์',
                          style: FontTheme.h4.copyWith(
                            color: ColorTheme.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'แนบใบประกอบวิชาชีพและกรอกข้อมูลด้านล่าง',
                    style: FontTheme.body2,
                  ),
                  ImageUploadScreen(),
                  Row(
                    children: [
                      Expanded(
                        child: InputTextField(
                          controller: _firstnameController,
                          hintText: 'กรอกชื่อ',
                          labelText: 'ชื่อ',
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: InputTextField(
                          controller: _lastnameController,
                          hintText: 'กรอกนามสกุล',
                          labelText: 'นามสกุล',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  InputTextField(
                    controller: _licenseController,
                    hintText: 'กรอกเลขที่ใบอนุญาต',
                    labelText: 'เลขที่ใบอนุญาต',
                  ),
                  SizedBox(height: 10),
                  InputDateField(
                    controller: _dateController,
                    hintText: 'กรอกวันที่ออกใบอนุญาต',
                    labelText: 'วันที่ออก',
                  ),
                  SizedBox(height: 20),
                  MdPrimaryButton(text: 'ลงทะเบียน',                         
                  onPressed: () {},
                  foregroundColor: Colors.white, // Change text color
                  backgroundColor: ColorTheme.successAction,
                  borderColor: ColorTheme.successAction, // Change button background color
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}