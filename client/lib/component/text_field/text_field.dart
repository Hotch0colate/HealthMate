import 'package:flutter/material.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';

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

class PasswordInputTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText; // New property for the label text

  const PasswordInputTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText, // Updated constructor
  }) : super(key: key);

  @override
  _PasswordInputTextFieldState createState() => _PasswordInputTextFieldState();
}

class _PasswordInputTextFieldState extends State<PasswordInputTextField> {
  late FocusNode _focusNode; // Declare a single FocusNode
  bool _obscureText = true; // Initially obscure the text

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
            Text(
              ' *',
              style: FontTheme.body1.copyWith(color: ColorTheme.errorAction),
            ),
          ],
        ),
        SizedBox(height: 5), // Add some space between label and text field
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _focusNode.hasFocus ? Colors.white : Colors.grey[200],
            border: Border.all(
              color: Colors.black12, // Adjusted border color
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode, // Use the same focus node instance
            obscureText: _obscureText, // Obscure the text
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
              // suffixIcon: IconButton(
              //   onPressed: () {
              //     setState(() {
              //       _obscureText = !_obscureText; // Toggle obscureText
              //     });
              //   },
              //   icon: Icon(
              //     _obscureText ? Icons.visibility : Icons.visibility_off,
              //     color: _obscureText ? Colors.grey : ColorTheme.primaryColor,
              //   ),
              // ),
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
