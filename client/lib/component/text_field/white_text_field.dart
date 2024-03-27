import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

class WhiteTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const WhiteTextField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: ColorTheme.WhiteColor,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle:FontTheme.body2,
          contentPadding: const EdgeInsets.only(left: 24, right: 24),
        ),
      ),
    );
  }
}
