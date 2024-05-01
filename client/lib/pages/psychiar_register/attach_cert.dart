import 'dart:convert';
import 'dart:io';

import 'package:client/pages/psychiar_register/psy_select_tag.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/services/ip_variable.dart';
import 'package:http/http.dart' as http;

import 'package:client/component/buttons.dart';
import 'package:client/component/text_field/date_picker.dart';
import 'package:client/component/text_field/text_field.dart';
import 'package:client/pages/psychiar_register/finish_register.dart';
import 'package:client/pages/psychiar_register/loading_register.dart';
import 'package:client/pages/psychiar_register/register.dart';
import 'package:client/pages/psychiar_register/upload_image.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AttachCertificate extends StatefulWidget {
  @override
  _AttachCertificateState createState() => _AttachCertificateState();
}

class _AttachCertificateState extends State<AttachCertificate> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  File? _selectedImage;

  void _handleImageSelection(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.WhiteColor,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        // Wrap with SingleChildScrollView
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
                          Icons.arrow_back_ios, // Replace with your custom icon
                          color: Colors.black38,
                          size: 30, // Customize the icon color
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PsyRegister()),
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
                    style: FontTheme.caption,
                  ),
                  SizedBox(height: 10),
                  ImageUploadScreen(
                    onFileSelected: _handleImageSelection,
                  ),
                  SizedBox(height: 10),
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
                  CupertinoDatePickerField(
                    controller: _dateController,
                    hintText: 'เลือกวันที่ออกใบอนุญาต',
                    labelText: 'วันที่ออกใบอนุญาต',
                  ),
                  SizedBox(height: 20),
                ],
              ),
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
                    builder: (context) => const PsyRegister(),
                  ),
                );
              },
            ),
            ForwardButton(
                // Disable the button if not all checkboxes are checked
                onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PsySelectTag(
                    firstnameText: _firstnameController.text,
                    lastnameText: _lastnameController.text,
                    licenseText: _licenseController.text,
                    dateText: _dateController.text,
                    selectedImage: _selectedImage,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class MyDatePickerWidget extends StatefulWidget {
  @override
  _MyDatePickerWidgetState createState() => _MyDatePickerWidgetState();
}

class _MyDatePickerWidgetState extends State<MyDatePickerWidget> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.date,
      initialDateTime: selectedDate,
      onDateTimeChanged: (DateTime newDate) {
        setState(() {
          selectedDate = newDate;
        });
      },
    );
  }
}
