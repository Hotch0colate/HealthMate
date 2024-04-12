// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'package:client/component/buttons.dart';
import 'package:client/component/dropdown.dart';
import 'package:client/component/navigation.dart';
import 'package:client/component/text_field/date_picker.dart';
import 'package:client/component/text_field/text_field.dart';
import 'package:client/pages/profile/profile.dart';
import 'package:client/services/ip_variable.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:http/http.dart' as http;
// Import Firebase Auth

//page import
Map<String, String> Mymap = {
  'Student': 'นักเรียน/นิสิตนักศึกษา',
  'OfficeWorker': 'พนักงานบริษัทเอกชน',
  'PublicServant': 'พนักงานข้าราชการ',
  'StateEnterpriseEmployee': 'พนักงานรัฐวิสาหกิจ',
  'IndustryWorker': 'พนักงานโรงงานอุตสาหกรรม',
  'PrivateBusiness': 'เจ้าของธุรกิจ/ธุรกิจส่วนตัว',
  'Single': 'โสด',
  'Partnered': 'มีแฟนแล้ว',
  'Married': 'หมั้นแล้ว / แต่งงานแล้ว',
  'Divorced': 'ม่าย / หย่าร้าง / แยกกันอยู่',
  'NonBindingRelationship': 'อยู่ในความสัมพันธ์แบบไม่ผูกมัด',
  'Complicated': 'ค่อนข้างอธิบายยาก',
  'Female': 'หญิง',
  'Male': 'ชาย'
};
Map<String, String> Sendmap = {
  'นักเรียน/นิสิตนักศึกษา': 'Student',
  'พนักงานบริษัทเอกชน': 'OfficeWorker',
  'พนักงานข้าราชการ': 'PublicServant',
  'พนักงานรัฐวิสาหกิจ': 'StateEnterpriseEmployee',
  'พนักงานโรงงานอุตสาหกรรม': 'IndustryWorker',
  'เจ้าของธุรกิจ/ธุรกิจส่วนตัว': 'PrivateBusiness',
  'โสด': 'Single',
  'มีแฟนแล้ว': 'Partnered',
  'หมั้นแล้ว/แต่งงานแล้ว': 'Married',
  'ม่าย/หย่าร้าง/แยกกันอยู่': 'Divorced',
  'อยู่ในความสัมพันธ์แบบไม่ผูกมัด': 'NonBindingRelationship',
  'ค่อนข้างอธิบายยาก': 'Complicated',
  'หญิง': 'Female',
  'ชาย': 'Male'
};

String? sendUserName = '';
String? sendBirthDay = '';
String? sendGender = '';
String? sendCareer = '';
String? sendStatus = '';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthMate',
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String userName = '';
  String birthDay = '';
  String gender = '';
  String career = '';
  String status = '';
  String genderdict = '';
  String careerdict = '';
  String statusdict = '';
  String gendershow = '';
  String careershow = '';
  String statusshow = '';

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();

  String? _chosenGender;
  String? _chosenJob;
  String? _chosenStatus;

  @override
  void initState() {
    super.initState();
    // Call the function to fetch the username when the widget is initialized
    readUserData();
  }

  Future<void> _selectImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Handle uploading the selected image here
      print('Selected image path: ${image.path}');
    }
  }

  Future<void> readUserData() async {
    try {
      var _auth_service = AuthService();
      String? token = await _auth_service.getIdToken();

      final response = await http.get(
        Uri.parse('http://${fixedIp}:3000/user/read_data'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        dynamic responseData = json.decode(response.body);
        print(responseData['Data']);
        if (responseData != null && responseData is Map<String, dynamic>) {
          Map<String, dynamic> data = json.decode(response.body)['Data'];
          String gender = data['gender'];
          career = data['career'];
          status = data['martialstatus'];
          String? genderdict = Mymap[gender];
          String? careerdict = Mymap[career];
          String? statusdict = Mymap[status];
          print('from read data');
          print(careerdict);
          print(genderdict);
          print(statusdict);
          print(data['username']);
          print(data['birthday']);
          setState(() {
            userName = data['username'] ?? '';
            birthDay = data['birthday'] ?? '';
            gendershow = genderdict ?? '';
            careershow = careerdict ?? '';
            statusshow = statusdict ?? '';
          });
        } else {
          throw Exception('Invalid snapshot value or format');
        }
      } else {
        throw Exception('Failed to load username: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load username: $error');
    }
  }

  Future<void> SaveUserData() async {
    setState(() {
      sendUserName = _usernameController.text;
      sendBirthDay = _birthDateController.text;
      sendGender = _chosenGender;
      sendCareer = _chosenJob;
      sendStatus = _chosenStatus;
    });
  }

  void _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 150,
          width: 300,
          child: AlertDialog(
            title: Column(
              children: [
                Text('คุณแน่ใจหรือไม่ \n กรุณายืนยันการบันทึกการแก้ไข',
                    style: FontTheme.body1.copyWith(color: Colors.black),
                    textAlign: TextAlign.center),
              ],
            ),
            actions: const <Widget>[
              Confirm(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
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
                            Icons
                                .arrow_back_ios, // Replace with your custom icon
                            color: Colors.black38,
                            size: 30, // Customize the icon color
                          ),
                          onPressed: () {
                            Navigator.pop(
                              context,
                            );
                          },
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        _selectImage(context);
                      },
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/avatar/md_11.png',
                            width: 80,
                          ),
                          Positioned(
                            bottom: 10,
                            right: 0,
                            child: Icon(
                              CupertinoIcons.pencil_circle_fill,
                              color: Colors.black87,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    InputTextField(
                        controller: _usernameController,
                        hintText: userName,
                        labelText: 'ชื่อผู้ใช้'),
                    SizedBox(height: 10),
                    ReusableDropdown(
                      value: _chosenGender,
                      items: [
                        'หญิง',
                        'ชาย',
                        'อื่นๆ ',
                      ],
                      onChanged: (String? Gendervalue) {
                        setState(() {
                          _chosenGender = Gendervalue;
                        });
                      },
                      hintText: gendershow,
                      label: 'เพศ',
                    ),
                    SizedBox(height: 10),
                    CupertinoDatePickerField(
                      controller: _birthDateController,
                      hintText: birthDay,
                      labelText: 'วันเกิด',
                    ),
                    SizedBox(height: 10),
                    ReusableDropdown(
                      value: _chosenJob,
                      items: [
                        'นักเรียน/นิสิตนักศึกษา',
                        'พนักงานบริษัทเอกชน',
                        'พนักงานข้าราชการ',
                        'พนักงานรัฐวิสาหกิจ',
                        'พนักงานโรงงานอุตสาหกรรม',
                        'เจ้าของธุรกิจ/ธุรกิจส่วนตัว',
                      ],
                      onChanged: (String? JobValue) {
                        setState(() {
                          _chosenJob = JobValue;
                        });
                      },
                      hintText: careershow,
                      label: 'อาชีพ',
                    ),
                    SizedBox(height: 10),
                    ReusableDropdown(
                      value: _chosenStatus,
                      items: [
                        'โสด',
                        'มีแฟนแล้ว',
                        'หมั้นแล้ว/แต่งงานแล้ว',
                        'ม่าย/หย่าร้าง/แยกกันอยู่',
                        'อยู่ในความสัมพันธ์แบบไม่ผูกมัด',
                        'ค่อนข้างอธิบายยาก',
                      ],
                      onChanged: (String? StatusValue) {
                        setState(() {
                          _chosenStatus = StatusValue;
                        });
                      },
                      hintText: statusshow,
                      label: 'สถานะ',
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly, // Align buttons horizontally

                      children: [
                        MdPrimaryButton(
                          text: 'บันทึก',
                          onPressed: () {
                            _showConfirmDialog(context);
                            SaveUserData();
                            print('from SaveUserData');
                            print(sendUserName);
                            print(sendBirthDay);
                            print(sendGender);
                            print(sendCareer);
                            print(sendStatus);
                          },
                          foregroundColor: ColorTheme.WhiteColor,
                        ),
                        MdPrimaryButton(
                          text: 'ยกเลิก',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          foregroundColor: ColorTheme.WhiteColor,
                          backgroundColor: Colors.black12,
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class Confirm extends StatelessWidget {
  const Confirm({super.key});

  Future<void> updateUserData() async {
    try {
      var _auth_service = AuthService();
      String? token = await _auth_service.getIdToken();

      // Assuming you have an API endpoint URL for updating user data
      String url = 'http://${fixedIp}:3000/user/update_data';
      print('from send data');
      print(sendUserName);
      print(sendBirthDay);
      print(sendGender);
      print(sendCareer);
      print(sendStatus);
      print("1");
      String? genderdict = Sendmap[sendGender];
      String? careerdict = Sendmap[sendCareer];
      String? statusdict = Sendmap[sendStatus];
      print(genderdict);
      print(careerdict);
      print(statusdict);

      Map<String, dynamic> updatedData = {
        'username': sendUserName,
        'birthday': sendBirthDay,
        'gender': genderdict,
        'career': careerdict,
        'martialstatus': statusdict,
      };

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(updatedData),
      );

      if (response.statusCode == 200) {
        print('User data updated successfully');
        // Handle successful update here, maybe navigate or show a success message
      } else {
        throw Exception('Failed to update user data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to update user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 296,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: ColorTheme.baseColor.withOpacity(0.8),
              backgroundColor: ColorTheme.WhiteColor,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                    color: ColorTheme.baseColor.withOpacity(0.2), width: 2),
              ),
            ),
            child: const Text('ยกเลิก', style: FontTheme.btn_small),
          ),
          SingleChildScrollView(
            child: ElevatedButton(
              onPressed: () {
                updateUserData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainApp(SelectedPage: 3)),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: ColorTheme.WhiteColor,
                backgroundColor: ColorTheme.successAction,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.transparent),
                ),
              ),
              child: const Text('ใช่ ยืนยัน', style: FontTheme.btn_small),
            ),
          ),
        ],
      ),
    );
  }
}
