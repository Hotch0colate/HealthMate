import 'package:client/pages/select_talk/find_volunteer_page.dart';
import 'package:client/component/navigation.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TalkPage extends StatelessWidget {
  final int selectedPage;
  final Function(int) onPageSelected;

  const TalkPage(
      {super.key, required this.selectedPage, required this.onPageSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: AppBar(
          title: Image.asset('assets/logos/small_app_name.png'),
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(left: 13, right: 13),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                children: [
                  const SizedBox(
                    height: 31,
                  ),
                  Text(
                    'พูดคุย',
                    style:
                        FontTheme.h2.copyWith(color: ColorTheme.primaryColor),
                  ),
                  const SizedBox(
                    height: 31,
                  ),
                  CustomCard(
                    onPressed: () {},
                    backgroundColor: ColorTheme.secondaryColor.withOpacity(0.3),
                    text: 'จิตแพทย์',
                    imageName: 'assets/images/Psychiatrist tool glasses.png',
                  ),
                  const SizedBox(
                    height: 31,
                  ),
                  CustomCard(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const FindVolunteerPage(), // Example: Navigate to a specific screen
                        ),
                      );
                    },
                    backgroundColor: ColorTheme.primary2Color.withOpacity(0.4),
                    text: 'อาสาสมัคร',
                    imageName: 'assets/images/Volunteer scarf.png',
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatefulWidget {
  final String text;
  final String imageName;
  final Color backgroundColor;
  final VoidCallback onPressed;
  const CustomCard({
    super.key,
    required this.text,
    required this.imageName,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  double scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      scale = 0.95; // Slightly smaller when tapping down
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      scale = 1.0; // Return to original size
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTap: widget.onPressed,
      onTapCancel: () {
        setState(() {
          scale = 1.0; // Ensure the scale is reset if the tap is canceled
        });
      },
      child: Transform.scale(
        scale: scale,
        child: Container(
          height: 233,
          width: 342,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 19,
              ),
              Image.asset(widget.imageName),
              Text(widget.text,
                  style: FontTheme.subtitle1.copyWith(color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
