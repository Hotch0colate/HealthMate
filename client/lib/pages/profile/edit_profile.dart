// ignore_for_file: use_build_context_synchronously
import 'package:client/component/buttons.dart';
import 'package:client/component/dropdown.dart';
import 'package:client/component/text_field/date_picker.dart';
import 'package:client/component/text_field/text_field.dart';
import 'package:client/pages/profile/profile.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// Import Firebase Auth

//page import

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
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();

  String? _chosenGender;
  String? _chosenJob;
  String? _chosenStatus;

  Future<void> _selectImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Handle uploading the selected image here
      print('Selected image path: ${image.path}');
    }
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
                Text(
                  'คุณแน่ใจหรือไม่ \n กรุณายืนยันการบันทึกการแก้ไข',
                  style: FontTheme.body1.copyWith(color: Colors.black),
                  textAlign: TextAlign.center
                ),
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
                        hintText: 'Leothecat11',
                        labelText: 'ชื่อผู้ใช้'),
                    SizedBox(height: 10),
                    ReusableDropdown(
                      value: _chosenGender,
                      items: [
                        'หญิง',
                        'ชาย',
                        'อื่นๆ ',
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          _chosenGender = newValue;
                        });
                      },
                      hintText: "หญิง",
                      label: 'เพศ',
                    ),
                    SizedBox(height: 10),
                    CupertinoDatePickerField(
                      controller: _birthDateController,
                      hintText: '2003-05-12',
                      labelText: 'วันเกิด',
                    ),
                    SizedBox(height: 10),
                    ReusableDropdown(
                      value: _chosenJob,
                      items: [
                        'นักเรียน/นิสิตนักศึกษา',
                        'พนักงานบริษัทเอกชน',
                        'พนักงานข้าราชการ ',
                        'พนักงานรัฐวิสาหกิจ ',
                        'พนักงานโรงงานอุตสาหกรรม ',
                        'เจ้าของธุรกิจ/ธุรกิจส่วนตัว ',
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          _chosenJob = newValue;
                        });
                      },
                      hintText: "พนักงานบริษัทเอกชน",
                      label: 'อาชีพ',
                    ),
                    SizedBox(height: 10),
                    ReusableDropdown(
                      value: _chosenStatus,
                      items: [
                        'โสด',
                        'มีแฟนแล้ว',
                        'หมั้นแล้ว / แต่งงานแล้ว ',
                        'ม่าย / หย่าร้าง / แยกกันอ ',
                        'อยู่ในความสัมพันธ์แบบไม่ผูกมัด ',
                        'ค่อนข้างอธิบายยาก',
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          _chosenStatus = newValue;
                        });
                      },
                      hintText: "โสด",
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => TalkPage()),
                // );
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
