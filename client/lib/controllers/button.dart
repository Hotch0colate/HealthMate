import 'package:flutter/material.dart';

import 'package:client/theme/font.dart';
import 'package:client/theme/color.dart';

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

  const SmPrimaryButton({
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

  const SmSecondaryButton({
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
      child: Text(text, style: FontTheme.btn_small),
    );
  }
}

class SmSecondaryButtonGrey extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SmSecondaryButtonGrey({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
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
      child: Text(text, style: FontTheme.btn_small),
    );
  }
}
