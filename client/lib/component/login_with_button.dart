import 'package:flutter/material.dart';

class LoginWithButton extends StatelessWidget {
  final String imagePath;

  const LoginWithButton({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0, // Adjust elevation as needed
      shape: const CircleBorder(),
      child: Container(
        height: 55,
        width: 55,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
          child: Image.asset(
            imagePath,
            height: 25,
            width: 25,
          ),
        ),
      ),
    );
  }
}
