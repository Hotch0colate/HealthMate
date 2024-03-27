import 'package:client/Pages/select_talk/find_volunteer_page.dart';
import 'package:client/component/buttons.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

class CreateTagPage extends StatefulWidget {
  const CreateTagPage({Key? key});

  @override
  _CreateTagPageState createState() => _CreateTagPageState();
}

class _CreateTagPageState extends State<CreateTagPage> {
  int selectedIndex = -1;
  final _formKey = GlobalKey<FormState>();

  TextEditingController descriptionTextController = TextEditingController();

  List<String> _tagOptions() =>
      ["Responbility", "Relation", "Health", "Generic"];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/icons/back_new.png'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.08,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.02),
                Image.asset('assets/images/Volunteer scarf.png'),
                Text(
                  'อาสาสมัคร',
                  style: FontTheme.subtitle1.copyWith(color: Colors.black),
                ),
                SizedBox(height: screenHeight * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.003),
                      child: Text(
                        'คุณเครียดเรื่องอะไร ?',
                        style:
                            FontTheme.subtitle2.copyWith(color: Colors.black),
                      ),
                    )
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  children: [
                    TagButton(
                      text: 'ภาระหน้าที่',
                      index: 0,
                      isSelected: selectedIndex == 0,
                      onSelect: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                    ),
                    SizedBox(width: screenWidth * 0.005),
                    TagButton(
                      text: 'ความสัมพันธ์',
                      index: 1,
                      isSelected: selectedIndex == 1,
                      onSelect: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                    ),
                    SizedBox(width: screenWidth * 0.005),
                    TagButton(
                      text: 'สุขภาพ',
                      index: 2,
                      isSelected: selectedIndex == 2,
                      onSelect: () {
                        setState(() {
                          selectedIndex = 2;
                        });
                      },
                    ),
                    SizedBox(width: screenWidth * 0.005),
                    TagButton(
                      text: 'ทั่วไป',
                      index: 3,
                      isSelected: selectedIndex == 3,
                      onSelect: () {
                        setState(() {
                          selectedIndex = 3;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.01),
                      child: Text('รายละเอียด',
                          style: FontTheme.subtitle2
                              .copyWith(color: Colors.black)),
                    )
                  ],
                ),
                SizedBox(height: screenHeight * 0.005),
                TextFormField(
                  controller: descriptionTextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      borderSide: BorderSide(
                        color: ColorTheme.baseColor.withOpacity(0.4),
                      ),
                    ),
                  ),
                  maxLines: 6,
                ),
                SizedBox(height: screenHeight * 0.015),
                MdPrimaryButton(
                  text: 'ค้นหาอาสาสมัคร',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FindVolunteerPage(
                          selectedTag: _tagOptions()[selectedIndex],
                          text: descriptionTextController.text,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                SmSecondaryButton(
                  text: 'ลงทะเบียนอาสาสมัคร',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TagButton extends StatelessWidget {
  final String text;
  final int index;
  final bool isSelected;
  final VoidCallback onSelect;

  const TagButton({
    required this.text,
    required this.index,
    required this.isSelected,
    required this.onSelect,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.02,
          vertical: screenWidth * 0.010,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isSelected ? ColorTheme.primaryColor : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : ColorTheme.baseColor.withOpacity(0.4),
          ),
        ),
        child: Text(
          text,
          style: FontTheme.btn_small.copyWith(
              color: isSelected
                  ? Colors.white
                  : ColorTheme.baseColor.withOpacity(0.4)),
        ),
      ),
    );
  }
}
