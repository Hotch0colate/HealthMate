import 'package:flutter/material.dart';

class LongTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const LongTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90, // Consider making height flexible if needed
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
          contentPadding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 12,
              bottom: 12), // Adjust padding for better text alignment
        ),
        keyboardType: TextInputType.multiline, // Set keyboard type to multiline
        maxLines: null, // Allows for an unlimited number of lines
      ),
    );
  }
}
