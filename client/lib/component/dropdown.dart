import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

class ReusableDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final String label;
  final ValueChanged<String?>? onChanged;
  final String hintText;

  ReusableDropdown({
    required this.value,
    required this.items,
    required this.label,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 10),
            Text(label, style: FontTheme.subtitle2),
            Text(' *',
                style: FontTheme.body2.copyWith(color: ColorTheme.errorAction)),
          ],
        ),
        SizedBox(height: 3), // Spacer between label and dropdown
        Container(
          height: 50,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
              color: Colors.black12, // Adjusted border color
              width: 1,
            ),
          ),
          child: DropdownButton<String>(
            value: value,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    SizedBox(width: 10), // SizedBox before hint text
                    Text(
                      value,
                      style: FontTheme.body2,
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: onChanged,
            hint: Row(
              children: [
                SizedBox(width: 10), // SizedBox before hint text
                Text(
                  hintText,
                  style: FontTheme.body2,
                ),
              ],
            ),
            isExpanded: true,
            underline: SizedBox(), // Remove default underline
          ),
        ),
      ],
    );
  }
}
