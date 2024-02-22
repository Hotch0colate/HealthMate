import 'package:flutter/material.dart';

class OrangeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const OrangeButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.orange),
      ),
      child: SizedBox(
        height: 60,
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
