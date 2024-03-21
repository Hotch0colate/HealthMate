import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

class ColorChangingCheckbox extends StatefulWidget {
  final String text;
  final ValueChanged<bool> onChanged;

  const ColorChangingCheckbox({
    required Key key,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  _ColorChangingCheckboxState createState() => _ColorChangingCheckboxState();
}

class _ColorChangingCheckboxState extends State<ColorChangingCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Transform.scale(
          scale: 1.3, // Change the scale factor to adjust checkbox size
          child: Checkbox(
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value!;
              });
              widget.onChanged(value!);
            },
            activeColor: ColorTheme.primaryColor, // Change checkbox color to orange
          ),
        ),
        Text(widget.text,
            style: FontTheme.body2.copyWith(
                color: isChecked
                    ? ColorTheme.primaryColor
                    : ColorTheme
                        .baseColor // Change text color to orange when checked
                )),
      ],
    );
  }
}
