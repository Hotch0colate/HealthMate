import 'dart:math';

import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

class VolunteerCongrats extends StatelessWidget {
  const VolunteerCongrats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(
            left: 40,
            right: 40,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/Volunteer scarf.png'),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'ยินดีด้วย!',
                  style: FontTheme.h2.copyWith(color: ColorTheme.baseColor),
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'คุณเป็นอาสาสมัครของ ',
                        style: FontTheme.body1
                            .copyWith(color: ColorTheme.baseColor),
                      ),
                      TextSpan(
                        text: 'Health',
                        style: FontTheme.body1
                            .copyWith(color: ColorTheme.secondaryColor),
                      ),
                      TextSpan(
                        text: 'Mate ',
                        style: FontTheme.body1
                            .copyWith(color: ColorTheme.primaryColor),
                      ),
                      TextSpan(
                        text: 'แล้ว',
                        style: FontTheme.body1
                            .copyWith(color: ColorTheme.baseColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorTheme.primaryColor,
                    padding: const EdgeInsets.only(
                        left: 11, right: 11, top: 13, bottom: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: Image.asset(
                      'assets/icons/back_new.png',
                      width: 35.0,
                      height: 35.0,
                      color: ColorTheme.WhiteColor,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
