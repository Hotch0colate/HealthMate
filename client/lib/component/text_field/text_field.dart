import 'package:flutter/material.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';


class InputTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText; 
  final bool showLabel;// New property for the label text

  const InputTextField({
    Key? key,
    required this.controller,
    this.hintText = 'hint text',
    this.labelText = 'hint text',
    this.showLabel = true, // Default to true
 // Updated constructor
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
         if (widget.showLabel) // Conditionally render label
        Row(
          // Row to display label text and asterisk
          children: [
            SizedBox(width: 10),
            Text(
              widget.labelText, // Display the label text
              style: FontTheme.subtitle2,
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
            SizedBox(width: 10),
            Text(
              widget.labelText, // Display the label text
              style: FontTheme.subtitle2,
            ),
            Text(
              ' *',
              style:
                  FontTheme.subtitle2.copyWith(color: ColorTheme.errorAction),
            ),
          ],
        ),
        SizedBox(height: 5), // Add some space between label and text field
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
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
              icon: Align(
                widthFactor: 1.0,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText; // Toggle obscureText
                    });
                  },
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: _obscureText ? Colors.grey : ColorTheme.primaryColor,
                  ),
                ),
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
            color: Colors.white,
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

class NormalPasswordTextField extends StatelessWidget {
  final TextEditingController controller;

  const NormalPasswordTextField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PasswordInputTextField(
      controller: controller,
      hintText: 'กรอกรหัสผ่าน',
      labelText: 'รหัสผ่าน',
    );
  }
}

class ConfirmPasswordTextField extends StatelessWidget {
  final TextEditingController controller;

  const ConfirmPasswordTextField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PasswordInputTextField(
      controller: controller,
      hintText: 'กรอกรหัสผ่านอีกครั้ง',
      labelText: 'ยืนยันรหัสผ่าน',
    );
  }
}

class MultilineInputTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const MultilineInputTextField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  _MultilineInputTextFieldState createState() =>
      _MultilineInputTextFieldState();
}

class _MultilineInputTextFieldState extends State<MultilineInputTextField> {
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
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _focusNode.hasFocus
                ? ColorTheme.primaryColor // Adjusted focused border color
                : Colors.black12, // Adjusted border color
            width: 1,
          ),
        ),
        child: TextField(
          controller: widget.controller,
          focusNode: _focusNode, // Use the same focus node instance
          maxLines: null, // Enable multiline
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: FontTheme.body2,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 24, vertical: 12), // Adjusted padding
            border: InputBorder.none, // Remove default border
          ),
        ),
      ),
    ],
  );
}
}
