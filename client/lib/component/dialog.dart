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
  bool healthConsult= false;


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
                  )
              ),
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
                  )
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ColorChangingCheckbox(
                  key: UniqueKey(), 
                  text: 'ความสัมพันะื', 
                  onChanged: (bool value) {
                            // Callback when checkbox state changes
                            setState(() {
                              relationConsult =
                                  value; // Update the state when the checkbox state changes
                            });
                          },
                          value: relationConsult,
                  )
              ),
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
                  )
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SmPrimaryButton(text: 'บันทึก', onPressed: () {}),
              SmPrimaryButton(
                text: 'ยกเลิก',
                onPressed: () {Navigator.pop(context);},
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
              onPressed: () {},
              child: Text(
                widget.textRole,
                style:
                    FontTheme.caption.copyWith(color: ColorTheme.errorAction),
              ))
        ],
      ),
    );
  }
}
