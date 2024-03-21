import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoDatePickerField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText; // New property for the label text

  const CupertinoDatePickerField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText, // Updated constructor
  }) : super(key: key);

  @override
  _CupertinoDatePickerFieldState createState() =>
      _CupertinoDatePickerFieldState();
}

class _CupertinoDatePickerFieldState extends State<CupertinoDatePickerField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: Column(
        // Wrap your content in a Column
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // Row to display label text and asterisk
            children: [
              Text(
                widget.labelText, // Display the label text
                style: FontTheme.body1,
              ),
              Text(' *',
                  style:
                      FontTheme.body2.copyWith(color: ColorTheme.errorAction)),
            ],
          ),
          SizedBox(height: 5),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12, // Adjusted border color
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CupertinoTextField(
                    controller: widget.controller,
                    placeholder: widget.hintText,
                    placeholderStyle:
                        FontTheme.body2.copyWith(color: Colors.black54),
                    readOnly: true,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                    ),
                  ),
                ),
                Icon(Icons.calendar_today,
                    color: Colors.black54), // Calendar icon
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: ColorTheme.WhiteColor,
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime dateTime) {
              widget.controller.text = dateTime
                  .toString()
                  .split(' ')[0]; // Display date in yyyy-MM-dd format
            },
          ),
        );
      },
    );

    if (picked != null && picked != widget.controller.text) {
      setState(() {
        widget.controller.text = picked
            .toString()
            .split(' ')[0]; // Display date in yyyy-MM-dd format
      });
    }
  }
}
