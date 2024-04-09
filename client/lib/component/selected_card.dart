import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

class SelectedCard extends StatefulWidget {
  final String text;
  final IconData icon;
  final Function(bool) onPressed;
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
  _SelectedCardState createState() => _SelectedCardState();
}

class _SelectedCardState extends State<SelectedCard> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    Color iconColor = _isSelected ? Colors.white : Colors.black;
    Color textColor = _isSelected ? Colors.white : Colors.black;

    return SizedBox(
      width: 168,
      height: 80,
      child: ElevatedButton.icon(
        onPressed: () {
          setState(() {
            _isSelected = !_isSelected;
          });
          widget.onPressed(_isSelected);
        },
        icon: Icon(
          widget.icon,
          color: iconColor,
        ),
        label: Text(
          widget.text,
          style: FontTheme.body2
        ),
        style: ElevatedButton.styleFrom(
          primary: _isSelected ? widget.mainColor : Colors.white,
          onPrimary: _isSelected ? Colors.white : Colors.black54,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: _isSelected ? widget.mainColor : Colors.grey.withOpacity(0.5),
              width: 2,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shadowColor: _isSelected ? Colors.black.withOpacity(0.5) : Colors.transparent,
        ),
      ),
    );
  }
}
