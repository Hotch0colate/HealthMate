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
            style: FontTheme.caption.copyWith(
                color: isChecked
                    ? ColorTheme.primaryColor
                    : ColorTheme
                        .baseColor // Change text color to orange when checked
                )),
      ],
    );
  }
}


class ColorChangingRadio extends StatefulWidget {
  final String text;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const ColorChangingRadio({
    Key? key,
    required this.text,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  _ColorChangingRadioState createState() => _ColorChangingRadioState();
}

class _ColorChangingRadioState extends State<ColorChangingRadio> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0), // Adjust vertical spacing here
      child: ListTile(
        contentPadding: EdgeInsets.zero, // Remove default ListTile padding
        title: Text(
          widget.text,
          style: TextStyle(
            color: widget.groupValue == widget.value
                ? ColorTheme.primaryColor
                : ColorTheme.baseColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontFamily: 'Athiti',
          ),
        ),
        leading: Radio<String>(
          value: widget.value,
          groupValue: widget.groupValue,
          onChanged: widget.onChanged,
          activeColor: Colors.orange,
        ),
      ),
    );
  }
}