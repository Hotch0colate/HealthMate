import 'package:flutter/material.dart';
import 'package:client/theme/font.dart';
import 'package:client/theme/color.dart';

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
        backgroundColor: ColorTheme.primaryColor,
        foregroundColor: ColorTheme.WhiteColor,
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

class GoBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoBackButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // Use the onPressed function passed as parameter
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromRGBO(34, 33, 33, 0.4),
        side: const BorderSide(
          color: Color.fromRGBO(34, 33, 33, 0.4),
        ),
      ),
      child: const SizedBox(
        height: 40,
        width: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 28,
              width: 28,
              child: Image(
                image: AssetImage(
                    'assets/icons/goback.png'), // Ensure the image path is correct
              ),
            ),
            Text(
              'ก่อนหน้า',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForwardButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ForwardButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // Use the onPressed function passed as parameter
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: ColorTheme.primaryColor,
        foregroundColor: ColorTheme.WhiteColor,
        side: const BorderSide(color: Colors.orange),
      ),
      child: const SizedBox(
        height: 40,
        width: 118,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ต่อไป',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 28,
              width: 28,
              child: Image(
                image: AssetImage(
                    'assets/icons/foward.png'), // Ensure the image path is correct
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LgPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LgPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: ColorTheme.WhiteColor,
        backgroundColor: ColorTheme.primaryColor, // Text color
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(text, style: FontTheme.btn_large),
    );
  }
}

class MdPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MdPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: ColorTheme.WhiteColor,
        backgroundColor: ColorTheme.primaryColor, // Text color
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(text, style: FontTheme.btn_medium),
    );
  }
}

class MdPrimaryButtonRed extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MdPrimaryButtonRed({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: ColorTheme.WhiteColor,
        backgroundColor: ColorTheme.errorAction, // Text color
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(text, style: FontTheme.btn_medium),
    );
  }
}

class SmPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color foregroundColor;
  final Color backgroundColor;
  final Color borderColor;
  final double minWidth;

  const SmPrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.foregroundColor = ColorTheme.WhiteColor,
    this.backgroundColor = ColorTheme.primaryColor,
    this.borderColor = ColorTheme.primaryColor,
    this.minWidth = 120, // Set your desired minimum width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: borderColor, width: 2),
        ),
        minimumSize: Size(minWidth, 0),
      ),
      child: Text(text, style: FontTheme.btn_small),
    );
  }
}

class LgSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LgSecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: ColorTheme.primaryColor,
        backgroundColor: ColorTheme.WhiteColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: ColorTheme.primaryColor, width: 2),
        ),
      ),
      child: Text(text, style: FontTheme.btn_large),
    );
  }
}

class MdSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MdSecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: ColorTheme.primaryColor,
        backgroundColor: ColorTheme.WhiteColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: ColorTheme.primaryColor, width: 2),
        ),
      ),
      child: Text(text, style: FontTheme.btn_medium),
    );
  }
}

class SmSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color foregroundColor;
  final Color backgroundColor;
  final Color borderColor;
  final double minWidth;

  const SmSecondaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.foregroundColor = ColorTheme.baseColor,
    this.backgroundColor = ColorTheme.primaryColor,
    this.borderColor = ColorTheme.primaryColor,
    this.minWidth = 120, // Set your desired minimum width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: borderColor, width: 2),
        ),
        minimumSize: Size(minWidth, 0),
      ),
      child: Text(text, style: FontTheme.btn_small),
    );
  }
}
