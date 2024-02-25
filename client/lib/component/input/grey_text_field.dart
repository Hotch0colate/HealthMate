import 'package:flutter/material.dart';

class GreyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const GreyTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: Color(0x22212133),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
          contentPadding: const EdgeInsets.only(left: 24, right: 24),
        ),
      ),
    );
  }
}
