import 'package:flutter/material.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:intl/intl.dart';

class InputTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText; // New property for the label text

  const InputTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText, // Updated constructor
  }) : super(key: key);

  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  late FocusNode _focusNode; // Declare a single FocusNode

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(); // Initialize the FocusNode
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Dispose the FocusNode when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // Wrap with Column
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
                style: FontTheme.body2.copyWith(color: ColorTheme.errorAction)),
          ],
        ),
        SizedBox(height: 5), // Add some space between label and text field
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _focusNode.hasFocus ? Colors.white : ColorTheme.WhiteColor,
            border: Border.all(
              color: Colors.black12, // Adjusted border color
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode, // Use the same focus node instance
            onTap: () {
              setState(() {
                // No need to maintain _isFocused
                // Use focusNode.hasFocus directly
              });
            },
            onEditingComplete: () {
              setState(() {
                // No need to maintain _isFocused
                // Use focusNode.hasFocus directly
              });
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: FontTheme.body2.copyWith(color: Colors.black54),
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              border: InputBorder.none, // Remove default border
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorTheme.primaryColor,
                    width: 1), // Adjusted focused border color
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class InputLongTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText; // New property for the label text

  const InputLongTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText, // Updated constructor
  }) : super(key: key);

  @override
  _InputLongTextFieldState createState() => _InputLongTextFieldState();
}

class _InputLongTextFieldState extends State<InputTextField> {
  late FocusNode _focusNode; // Declare a single FocusNode

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(); // Initialize the FocusNode
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Dispose the FocusNode when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // Wrap with Column
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
                style: FontTheme.body2.copyWith(color: ColorTheme.errorAction)),
          ],
        ),
        SizedBox(height: 5), // Add some space between label and text field
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _focusNode.hasFocus ? Colors.white : ColorTheme.WhiteColor,
            border: Border.all(
              color: Colors.black12, // Adjusted border color
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode, // Use the same focus node instance
            onTap: () {
              setState(() {
                // No need to maintain _isFocused
                // Use focusNode.hasFocus directly
              });
            },
            onEditingComplete: () {
              setState(() {
                // No need to maintain _isFocused
                // Use focusNode.hasFocus directly
              });
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: FontTheme.body2.copyWith(color: Colors.black54),
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              border: InputBorder.none, // Remove default border
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorTheme.primaryColor,
                    width: 1), // Adjusted focused border color
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class InputDateField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;

  const InputDateField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  }) : super(key: key);

  @override
  _InputDateFieldState createState() => _InputDateFieldState();
}

class _InputDateFieldState extends State<InputDateField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != widget.controller.text) {
      setState(() {
        widget.controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

   @override
  Widget build(BuildContext context) {
    return SizedBox( 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.labelText,
                style: FontTheme.body1
              ),
              Text(
                ' *',
                style: TextStyle(
                  fontSize: 16, // Change font size if needed
                  color: Colors.red, // Change color if needed
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: TextFormField(
                controller: widget.controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: widget.hintText,hintStyle: FontTheme.body2,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white, // Customize border color
                      width: 1, // Set border width to 1
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.datetime,
              ),
            ),
          ),
        ],
      ),
    );
  }
}