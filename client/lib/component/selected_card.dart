import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

class SelectedCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isSelected;
  final Color mainColor;
 

  const SelectedCard({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.isSelected = false,
    this.mainColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color iconColor = isSelected ? Colors.white : Colors.black;
    Color textColor = isSelected ? Colors.white : Colors.black;

    return SizedBox(
      width: 168,
      height: 80,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: iconColor,
        ),
        label: Text(
          text,
          style: FontTheme.body2.copyWith(color: textColor),
        ),
        style: ElevatedButton.styleFrom(
          primary: isSelected ? mainColor: ColorTheme.WhiteColor,
          onPrimary: isSelected ? Colors.grey : Colors.black,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: isSelected ? mainColor: ColorTheme.baseColor.withOpacity(0.5),
            width: 2)
            ,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shadowColor: isSelected ? Colors.black.withOpacity(1) : Colors.transparent,
        ),
      ),
    );
  }
}
