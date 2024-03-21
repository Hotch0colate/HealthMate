import 'package:client/pages/psychiar/finish_register.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

class LoadingPsyRegister extends StatelessWidget {
  const LoadingPsyRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,// Center content horizontally
              children: [
                Text(
                  'กำลังตรวจสอบ',
                  style: FontTheme.h3.copyWith(color: ColorTheme.primaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const AnimatedBackground(), // This will display the animation
                    Image.asset(
                      'assets/psy/psy_cat.png',
                      width: 60,
                      fit: BoxFit.fill,
                    ), // This will stay static on top
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'กรุณารอซักครู่ . . .',
                  style: FontTheme.subtitle1.copyWith(color: ColorTheme.secondaryColor),
                ),
                 IconButton(
                  icon: Icon(
                    Icons.abc,
                    color: ColorTheme.primaryColor,
                    size: 50,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FinishRegisterPsy()),
                    );
                  },
                )
              ],
            ),
          ),
        ),
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
      duration: const Duration(milliseconds: 1000), // Duration for each image
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
          width: 200, fit: BoxFit.contain),
      Image.asset('assets/loading_screen/loading_2.png',
          width: 200, fit: BoxFit.contain),
      Image.asset('assets/loading_screen/loading_3.png',
          width: 200, fit: BoxFit.contain),
      Image.asset('assets/loading_screen/loading_4.png',
          width: 200, fit: BoxFit.contain),
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
          const Duration(milliseconds: 2500), // Duration of fade between images
      child: _frames[_currentIndex % _frames.length],
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
