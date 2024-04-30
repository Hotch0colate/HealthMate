import 'package:client/pages/select_talk/create_tag_page_psy.dart';
import 'package:client/pages/select_talk/create_tag_page_volunteer.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TalkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.WhiteColor,
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "พูดคุย",
                style: FontTheme.h4.copyWith(color: ColorTheme.primaryColor),
              ),
              
            ],
          ),
        ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SelectTalkCard(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CreateTagPsyPage(), // Example: Navigate to a specific screen
                            ),
                          );
                        },
                        backgroundColor:
                            ColorTheme.secondaryColor.withOpacity(0.3),
                        text: 'จิตแพทย์',
                        imageName:
                            'assets/images/psychiatrist_tool_glasses.png',
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      SelectTalkCard(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CreateTagVolunteerPage(), // Example: Navigate to a specific screen
                            ),
                          );
                        },
                        backgroundColor:
                            ColorTheme.primary2Color.withOpacity(0.4),
                        text: 'อาสาสมัคร',
                        imageName: 'assets/images/volunteer_scarf.png',
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

class SelectTalkCard extends StatefulWidget {
  final String text;
  final String imageName;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const SelectTalkCard({
    Key? key,
    required this.text,
    required this.imageName,
    required this.backgroundColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<SelectTalkCard> createState() => _SelectTalkCardState();
}

class _SelectTalkCardState extends State<SelectTalkCard> {
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
    double cardHeight = MediaQuery.of(context).size.width * 0.4 * 1.5;
    double cardWidth = MediaQuery.of(context).size.width * 0.6 * 1.5;

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
          height: cardHeight,
          width: cardWidth,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 19,
              ),
              Image.asset(
                widget.imageName,
                height: cardHeight * 0.6,
              ),
              Text(
                widget.text,
                style: FontTheme.subtitle2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
