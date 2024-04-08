import 'package:client/Pages/select_talk/find_volunteer_page.dart';
import 'package:client/component/buttons.dart';
import 'package:client/component/navigation.dart';
import 'package:client/component/selected_card.dart';
import 'package:client/component/text_field/text_field.dart';
import 'package:client/pages/psychiar_register/register.dart';
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
    return MaterialApp(
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
          padding: EdgeInsets.all(20),
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
                      //กลับไปหน้า Select talk
                      //เปลี่ยน flow ตรงนี้ ตั้งเพื่อทดสอบการรันเฉยๆ
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
              SizedBox(height: 36),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SelectedCard(
                        text: 'ทั่วไป',
                        icon: Icons.emoji_emotions,
                        onPressed: () {
                          setState(() {
                            selectedCardIndex = 0;
                          });
                        },
                        isSelected: selectedCardIndex == 0,
                        mainColor: ColorTheme.secondaryColor,
                      ),
                      SelectedCard(
                        text: 'ภาระหน้าที่',
                        icon: Icons.work,
                        onPressed: () {
                          setState(() {
                            selectedCardIndex = 1;
                          });
                        },
                        isSelected: selectedCardIndex == 1,
                        mainColor: ColorTheme.secondaryColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SelectedCard(
                        text: 'ความสัมพันธ์',
                        icon: CupertinoIcons.person_3_fill,
                        onPressed: () {
                          setState(() {
                            selectedCardIndex = 2;
                          });
                        },
                        isSelected: selectedCardIndex == 2,
                        mainColor: ColorTheme.secondaryColor,
                      ),
                      SelectedCard(
                        text: 'สุขภาพ',
                        icon: CupertinoIcons.heart_fill,
                        onPressed: () {
                          setState(() {
                            selectedCardIndex = 3;
                          });
                        },
                        isSelected: selectedCardIndex == 3,
                        mainColor: ColorTheme.secondaryColor,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.01),
                    child: Text('รายละเอียด',
                        style:
                            FontTheme.subtitle2.copyWith(color: Colors.black)),
                  )
                ],
              ),
              SizedBox(height: screenHeight * 0.005),
              MultilineInputTextField(
                controller: descriptionTextController,
                hintText: 'ใส่รายละเอียด',
              ),
              SizedBox(height: 28),
              MdPrimaryButton(
                minWidth: 400,
                text: 'ค้นหาอาสาสมัคร',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FindVolunteerPage(
                        selectedTag: _tagOptions()[selectedCardIndex],
                        text: descriptionTextController.text,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1.5,
                      color: ColorTheme.secondaryColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'มาเป็นจิตแพทย์ด้วยกันไหมครับ',
                      style: FontTheme.body1
                          .copyWith(color: ColorTheme.secondaryColor),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1.5,
                      color: ColorTheme.secondaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              MdSecondaryButton(
                minWidth: 400,
                text: 'ลงทะเบียนจิตแพทย์',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VolunteerRegister(),
                      ));
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

// class TagButton extends StatelessWidget {
//   final String text;
//   final int index;
//   final bool isSelected;
//   final VoidCallback onSelect;

//   const TagButton({
//     required this.text,
//     required this.index,
//     required this.isSelected,
//     required this.onSelect,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     return GestureDetector(
//       onTap: onSelect,
//       child: Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: screenWidth * 0.02,
//           vertical: screenWidth * 0.010,
//         ),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           color: isSelected ? ColorTheme.primaryColor : Colors.transparent,
//           border: Border.all(
//             color: isSelected
//                 ? Colors.transparent
//                 : ColorTheme.baseColor.withOpacity(0.4),
//           ),
//         ),
//         child: Text(
//           text,
//           style: FontTheme.btn_small.copyWith(
//               color: isSelected
//                   ? Colors.white
//                   : ColorTheme.baseColor.withOpacity(0.4)),
//         ),
//       ),
//     );
//   }
// }
