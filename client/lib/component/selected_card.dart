import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

class MultipleSelectedCard extends StatefulWidget {
  final String text;
  final IconData icon;
  final Function(bool) onPressed;
  final bool isSelected;
  final Color mainColor;

  const MultipleSelectedCard({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.isSelected = false,
    this.mainColor = Colors.black,
  }) : super(key: key);

  @override
  _MultipleSelectedCardState createState() => _MultipleSelectedCardState();
}

class _MultipleSelectedCardState extends State<MultipleSelectedCard> {
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
          style: FontTheme.caption
        ),
        style: ElevatedButton.styleFrom(
          primary: _isSelected ? widget.mainColor : ColorTheme.WhiteColor,
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

class SelectedCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
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
  Widget build(BuildContext context) {
    Color iconColor = isSelected ? ColorTheme.WhiteColor : Colors.black;
    Color textColor = isSelected ? ColorTheme.WhiteColor : Colors.black;

    return SizedBox(
      width: 168,
      height: 80,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: iconColor,
        ),
        label: Text(
          text,
          style: FontTheme.caption.copyWith(color: textColor),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: isSelected ? Colors.grey : Colors.black, 
          backgroundColor: isSelected ? mainColor: ColorTheme.WhiteColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: isSelected ? mainColor: Colors.black.withOpacity(0.5),
            width: 2)
            ,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shadowColor: isSelected ? Colors.black.withOpacity(1) : Colors.transparent,
        ),
      ),
    );
  }
}
