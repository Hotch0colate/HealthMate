import 'package:client/component/buttons.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

class VolunteerTestWating extends StatelessWidget {
  const VolunteerTestWating({super.key});

  // This function is used to show the dialog when the button is pressed
  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 132,
          width: 296,
          child: AlertDialog(
            title: Column(
              children: [
                Text(
                  'คุณแน่ใจหรือไม่',
                  style: FontTheme.body1.copyWith(color: Colors.black),
                ),
                Text(
                  'กรุณายืนยันการยกเลิก?',
                  style: FontTheme.body1.copyWith(color: Colors.black),
                ),
              ],
            ),
            actions: const <Widget>[
              ConfirmDelete(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset('assets/icons/back_new.png',
                  width: 35, fit: BoxFit.contain),
            ],
          ),
          flexibleSpace: Image.asset(
            'assets/images/Vector.png',
            fit: BoxFit.cover,
          ),
          backgroundColor: Colors.transparent,
          toolbarHeight: 170,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  'กำลังตรวจสอบคำตอบของคุณ',
                  style: FontTheme.h3.copyWith(color: ColorTheme.primaryColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset('assets/images/Volunteer hat.png'),
                const SizedBox(
                  height: 35,
                ),
                const LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  minHeight: 10,
                  borderRadius: BorderRadius.all(Radius.circular(
                      10)), // This makes the progress bar orange
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'กรุณารอซักครู่',
                    style: FontTheme.subtitle1
                        .copyWith(color: ColorTheme.primaryColor),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class ConfirmDelete extends StatelessWidget {
  const ConfirmDelete({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 296,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              // Call the function to close the dialog
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
                // Call the function to close the dialog
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: ColorTheme.WhiteColor,
                backgroundColor: ColorTheme.errorAction,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.transparent),
                ),
              ),
              child: const Text('ใช่ ยกเลิกเลย', style: FontTheme.btn_small),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({Key? key}) : super(key: key);

  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Widget> _frames;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000), // Duration for each image
      vsync: this,
    )..addListener(() {
        final newIndex = (_controller.value * _frames.length).floor();
        if (newIndex != _currentIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        }
      });

    _controller.repeat(reverse: false); // Do not reverse the animation

    _frames = [
      Image.asset('assets/loading_screen/loading_1.png',
          width: 300, fit: BoxFit.contain),
      Image.asset('assets/loading_screen/loading_2.png',
          width: 300, fit: BoxFit.contain),
      Image.asset('assets/loading_screen/loading_3.png',
          width: 300, fit: BoxFit.contain),
      Image.asset('assets/loading_screen/loading_4.png',
          width: 300, fit: BoxFit.contain),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration:
          const Duration(milliseconds: 3000), // Duration of fade between images
      child: _frames[_currentIndex % _frames.length],
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
