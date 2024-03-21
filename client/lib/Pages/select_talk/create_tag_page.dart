import 'package:client/Pages/select_talk/find_volunteer_page.dart';
import 'package:client/component/buttons.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: CreateTagPage(),
//     );
//   }
// }

class CreateTagPage extends StatefulWidget {
  const CreateTagPage({super.key});

  @override
  _CreateTagPageState createState() => _CreateTagPageState();
}

class _CreateTagPageState extends State<CreateTagPage> {
  // This will keep track of the selected index
  int selectedIndex = -1;
  final _formKey = GlobalKey<FormState>();

  TextEditingController descriptionTextController = TextEditingController();

  List<String> _tagOptions() =>
      ["Responbility", "Relation", "Health", "Generic"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/icons/back_new.png'),
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Image.asset('assets/images/Volunteer scarf.png'),
              Text(
                'อาสาสมัคร',
                style: FontTheme.subtitle1.copyWith(color: Colors.black),
              ),
              const SizedBox(
                height: 28,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(
                    'คุณเครียดเรื่องอะไร ?',
                    style: FontTheme.subtitle2.copyWith(color: Colors.black),
                  ),
                )
              ]),
              const SizedBox(
                height: 11,
              ),
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
                  const SizedBox(width: 4),
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
                  const SizedBox(width: 4),
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
                  const SizedBox(width: 4),
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
              const SizedBox(
                height: 29,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: Text('รายละเอียด',
                      style: FontTheme.subtitle2.copyWith(color: Colors.black)),
                )
              ]),
              const SizedBox(height: 8),
              TextFormField(
                controller: descriptionTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: ColorTheme.baseColor.withOpacity(0.4),
                    ),
                  ),
                ),
                maxLines: 6,
              ),
              const SizedBox(
                height: 24,
              ),
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
              const SizedBox(
                height: 34,
              ),
              SmSecondaryButton(
                text: 'ลงทะเบียนอาสาสมัคร',
                onPressed: () {},
              ),
            ],
          ),
        ),
      )),
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
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
