import 'package:client/theme/color.dart';
import 'package:flutter/material.dart';

class SelectableCard extends StatefulWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final Widget child;
  final Color selectedColor;
  final Color unselectedColor;
  final Color borderColor;
  final double borderWidth;

  const SelectableCard({
    Key? key,
    this.isSelected = false,
    required this.onTap,
    required this.child,
    this.selectedColor = ColorTheme.primaryColor,
    this.unselectedColor = ColorTheme.WhiteColor,
    this.borderColor = Colors.black,
    this.borderWidth = 1,
  }) : super(key: key);

  @override
  _SelectableCardState createState() => _SelectableCardState();
}

class _SelectableCardState extends State<SelectableCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: widget.isSelected ? widget.selectedColor : widget.unselectedColor,
          border: Border.all(
            color: widget.borderColor,
            width: widget.borderWidth,
          ),
          borderRadius: BorderRadius.circular(16.0), // Adjust border radius as needed
        ),
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: widget.child,
            ),
          ),
      ),
    );
  }
}