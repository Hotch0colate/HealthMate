import 'package:client/component/navigation.dart';
import 'package:client/component/text_field/text_field.dart';
import 'package:client/pages/select_talk/select_talk_page.dart';
import 'package:client/pages/volunteer_register/volunteer_register.dart';
import 'package:flutter/material.dart';
import 'package:client/component/buttons.dart';
import 'package:client/component/select_box.dart';
import 'package:client/theme/color.dart'; // Import your color theme
import 'package:client/theme/font.dart'; // Import your font theme

class CancleRoleDialog extends StatefulWidget {
  final String textRole;

  CancleRoleDialog({required this.textRole});

  @override
  _CancleRoleDialogState createState() => _CancleRoleDialogState();
}

class _CancleRoleDialogState extends State<CancleRoleDialog> {
  // String? selectedTypeConsultValue;
  // String selectedTypeConsult = '';

  bool genericConsult = false;
  bool responsibilityConsult = false;
  bool relationConsult = false;
  bool healthConsult = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 8,
          ),
          Text(
            'เปลี่ยนหัวข้อให้คำปรึกษา',
            style: FontTheme.subtitle1.copyWith(color: ColorTheme.primaryColor),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                  child: ColorChangingCheckbox(
                key: UniqueKey(),
                text: 'ทั่วไป',
                onChanged: (bool value) {
                  // Callback when checkbox state changes
                  setState(() {
                    genericConsult =
                        value; // Update the state when the checkbox state changes
                  });
                },
                value: genericConsult,
              )),
              Expanded(
                  child: ColorChangingCheckbox(
                key: UniqueKey(),
                text: 'ภาระหน้าที่',
                onChanged: (bool value) {
                  // Callback when checkbox state changes
                  setState(() {
                    responsibilityConsult =
                        value; // Update the state when the checkbox state changes
                  });
                },
                value: responsibilityConsult,
              )),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: ColorChangingCheckbox(
                key: UniqueKey(),
                text: 'ความสัมพันธ์',
                onChanged: (bool value) {
                  // Callback when checkbox state changes
                  setState(() {
                    relationConsult =
                        value; // Update the state when the checkbox state changes
                  });
                },
                value: relationConsult,
              )),
              Expanded(
                  child: ColorChangingCheckbox(
                key: UniqueKey(),
                text: 'สุขภาพ',
                onChanged: (bool value) {
                  // Callback when checkbox state changes
                  setState(() {
                    healthConsult =
                        value; // Update the state when the checkbox state changes
                  });
                },
                value: healthConsult,
              )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SmPrimaryButton(
                  text: 'บันทึก',
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              SmPrimaryButton(
                text: 'ยกเลิก',
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: Colors.black12,
                borderColor: Colors.black12,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            thickness: 1,
          ),
          TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmDialogWithDetail(
                      title: 'คุณต้องการยกเลิกเพราะเหตุใด',
                      destination: MainApp(SelectedPage: 2),
                    );
                  },
                );
              },
              child: Text(
                widget.textRole,
                style: FontTheme.caption.copyWith(
                    fontWeight: FontWeight.w500, color: ColorTheme.errorAction),
              ))
        ],
      ),
    );
  }
}

class ConfirmDialogWithDetail extends StatefulWidget {
  final String title;
  final Color backgroundColor;
  final Widget destination;

  ConfirmDialogWithDetail({
    required this.title,
    this.backgroundColor = ColorTheme.successAction,
    required this.destination,
  });

  @override
  _ConfirmDialogWithDetailState createState() =>
      _ConfirmDialogWithDetailState();
}

class _ConfirmDialogWithDetailState extends State<ConfirmDialogWithDetail> {
  TextEditingController descriptionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 8,
          ),
          Text(
            widget.title,
            style: FontTheme.body1.copyWith(color: ColorTheme.baseColor),
          ),
          InputTextField(
            controller: descriptionTextController,
            showLabel: false,
            hintText: '',
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'กรุณายืนยันการยกเลิก',
            style: FontTheme.body2,
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SmPrimaryButton(
                text: 'ใช่ ยืนยัน',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => widget.destination),
                  );
                },
                backgroundColor: widget.backgroundColor,
                borderColor: widget.backgroundColor,
              ),
              SmPrimaryButton(
                text: 'ยกเลิก',
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: Colors.black12,
                borderColor: Colors.black12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ConfirmDialogWithNoDetail extends StatefulWidget {
  final String title;
  final Color backgroundColor;
  final Widget destination;

  ConfirmDialogWithNoDetail({
    required this.title,
    this.backgroundColor = ColorTheme.successAction,
    required this.destination,
  });

  @override
  _ConfirmDialogWithNoDetailState createState() =>
      _ConfirmDialogWithNoDetailState();
}

class _ConfirmDialogWithNoDetailState extends State<ConfirmDialogWithNoDetail> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 8,
          ),
          Text(
            widget.title,
            style: FontTheme.body1.copyWith(color: ColorTheme.baseColor),
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SmPrimaryButton(
                text: 'ใช่',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => widget.destination,
                    ),
                  );
                },
                backgroundColor: widget.backgroundColor,
                borderColor: widget.backgroundColor,
              ),
              SizedBox(
                width: 16,
              ),
              SmPrimaryButton(
                text: 'ไม่',
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: Colors.black12,
                borderColor: Colors.black12,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
