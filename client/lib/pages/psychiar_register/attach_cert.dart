import 'dart:convert';
import 'dart:io';

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

  void _createPsychiatrist() async {
    try {
      var _auth_service = AuthService();
      String? token = await _auth_service.getIdToken();

      var uri = Uri.parse('http://${fixedIp}:3000/psychiatrist/create_data');
      var request = http.MultipartRequest('POST', uri)
        ..fields['firstname'] = _firstnameController.text
        ..fields['lastname'] = _lastnameController.text
        ..fields['numbercertificate'] = _licenseController.text
        ..fields['datecertificate'] = _dateController.text
        ..headers['Authorization'] = 'Bearer $token';

      if (_selectedImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'certificateimage', // This is the field name that the server expects for the file
          _selectedImage!.path,
        ));
        print("_selectedImage != null");
      }

      var response = await request.send();

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to load emotions');
      }
    } catch (error) {
      throw Exception('Failed to load emotions: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    style: FontTheme.body2,
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
                  MdPrimaryButton(
                    text: 'ลงทะเบียน',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoadingPsyRegister()),
                      );
                      Future.delayed(const Duration(seconds: 3), () {
                        _createPsychiatrist();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FinishRegisterPsy()),
                        ); // Navigate back after 3 seconds
                      });
                    },
                    foregroundColor: Colors.white, // Change text color
                    backgroundColor: ColorTheme.successAction,
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
