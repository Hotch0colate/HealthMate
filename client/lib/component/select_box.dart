import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

class ColorChangingCheckbox extends StatefulWidget {
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ColorChangingCheckbox({
    required Key key,
    required this.text,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _ColorChangingCheckboxState createState() => _ColorChangingCheckboxState();
}

class _ColorChangingCheckboxState extends State<ColorChangingCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Wrap the row in GestureDetector
      onTap: () {
        setState(() {
          widget.onChanged(!widget.value);
        });
      },
      child: Row(
        children: <Widget>[
          Transform.scale(
            scale: 1.2, // Change the scale factor to adjust checkbox size
            child: Checkbox(
              value: widget.value,
              onChanged: (value) {
                setState(() {
                  widget.onChanged(value!);
                });
              },
              activeColor: ColorTheme.primaryColor, // Change checkbox color to orange
            ),
          ),
          Text(
            widget.text,
            style: FontTheme.caption.copyWith(
              fontWeight: FontWeight.w500,
              color: widget.value ? ColorTheme.primaryColor : ColorTheme.baseColor,
            ),
          ),
        ],
      ),
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
     return GestureDetector( // Wrap the ListTile in GestureDetector
      onTap: () {
        setState(() {
          widget.onChanged(widget.value);
        });
      },
      child: Padding(
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
            activeColor: ColorTheme.primaryColor,
          ),
        ),
      ),
    );
  }
}