import 'package:client/Pages/select_talk/find_volunteer_page.dart';
import 'package:client/component/buttons.dart';
import 'package:client/component/dialog.dart';
import 'package:client/component/navigation.dart';
import 'package:client/component/selected_card.dart';
import 'package:client/component/text_field/text_field.dart';
import 'package:client/pages/psychiar_register/register.dart';
import 'package:client/pages/select_talk/find_psy_page.dart';
import 'package:client/pages/volunteer_register/volunteer_register.dart';
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
    return const MaterialApp(
      home: CreateTagPsyPage(),
    );
  }
}

class CreateTagPsyPage extends StatefulWidget {
  const CreateTagPsyPage({Key? key});

  @override
  _CreateTagPsyPageState createState() => _CreateTagPsyPageState();
}

class _CreateTagPsyPageState extends State<CreateTagPsyPage> {
  bool isPsychiatrist = true; // Track psychiatrist status
  int selectedCardIndex = -1; // -1 indicates no card selected

  final _formKey = GlobalKey<FormState>();

  TextEditingController descriptionTextController = TextEditingController();

  List<String> _tagOptions() =>
      ["Generic", "Responbility", "Relation", "Health"];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
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
                      // Navigate back to the previous screen
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainApp(SelectedPage: 1)),
                        (Route<dynamic> route) =>
                            false, // Remove all routes below
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/images/psychiatrist_glasses.png',
                    width: 100,
                    height: 100,
                  ),
                  Text(
                    'เลือกเรื่องที่จะปรึกษา\nได้เลย เมี๊ยววว...',
                    style: FontTheme.subtitle1
                        .copyWith(color: ColorTheme.secondaryColor),
                  )
                ],
              ),
              const SizedBox(height: 36),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SelectedCard(
                        text: 'ทั่วไป',
                        icon: Icons.emoji_emotions,
                        onPressed: (isSelected) {
                          print('Card 1 is selected: $isSelected');
                        },
                        isSelected: false,
                        mainColor: ColorTheme.secondaryColor,
                      ),
                      SelectedCard(
                        text: 'ภาระหน้าที่',
                        icon: Icons.work,
                        onPressed: (isSelected) {
                          print('Card 1 is selected: $isSelected');
                        },
                        isSelected: false,
                        mainColor: ColorTheme.secondaryColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SelectedCard(
                        text: 'ความสัมพันธ์',
                        icon: CupertinoIcons.person_3_fill,
                        onPressed: (isSelected) {
                          print('Card 1 is selected: $isSelected');
                        },
                        isSelected: false,
                        mainColor: ColorTheme.secondaryColor,
                      ),
                      SelectedCard(
                        text: 'สุขภาพ',
                        icon: CupertinoIcons.heart_fill,
                        onPressed: (isSelected) {
                          print('Card 1 is selected: $isSelected');
                        },
                        isSelected: false,
                        mainColor: ColorTheme.secondaryColor,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.01),
                    child: Text(
                      'รายละเอียด',
                      style: FontTheme.subtitle2.copyWith(color: Colors.black),
                    ),
                  )
                ],
              ),
              SizedBox(height: screenHeight * 0.005),
              MultilineInputTextField(
                controller: descriptionTextController,
                hintText: 'ใส่รายละเอียด',
              ),
              const SizedBox(height: 28),
              MdPrimaryButton(
                minWidth: 400,
                text: 'ค้นหาจิตแพทย์',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FindPsyPage(
                        // selectedTag: _tagOptions()[selectedCardIndex],
                        text: descriptionTextController.text, selectedTag: '',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      thickness: 1.5,
                      color: ColorTheme.secondaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'มาเป็นจิตแพทย์ด้วยกันไหมครับ',
                      style: FontTheme.body1
                          .copyWith(color: ColorTheme.secondaryColor),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      thickness: 1.5,
                      color: ColorTheme.secondaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              isPsychiatrist
                  ? MdSecondaryButton(
                      minWidth: 400,
                      text: 'เปลี่ยน/ยกเลิกจิตแพทย์', // Change button text
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CancleRoleDialog(
                              textRole: 'ยกเลิกการเป็นจิตแพทย์',
                            );
                          },
                        );
                      },
                      borderColor: ColorTheme.errorAction,
                      foregroundColor: ColorTheme.errorAction,
                    )
                  : MdSecondaryButton(
                      minWidth: 400,
                      text: 'ลงทะเบียนจิตแพทย์', // Original button text
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PsyRegister(),
                          ),
                        );
                      },
                      borderColor: ColorTheme.secondaryColor,
                      foregroundColor: ColorTheme.secondaryColor,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
