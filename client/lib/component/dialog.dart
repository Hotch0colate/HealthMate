import 'package:client/component/navigation.dart';
import 'package:client/component/text_field/text_field.dart';
import 'package:client/pages/select_talk/select_talk_page.dart';
import 'package:client/pages/volunteer_register/volunteer_register.dart';
import 'package:flutter/material.dart';
import 'package:client/component/buttons.dart';
import 'package:client/component/select_box.dart';
import 'package:client/theme/color.dart'; // Import your color theme
import 'package:client/theme/font.dart'; // Import your font theme

import 'dart:convert';
import 'package:client/services/auth_service.dart';
import 'package:client/services/ip_variable.dart';
import 'package:http/http.dart' as http;

class CancleRoleDialog extends StatefulWidget {
  final String textRole;
  final String apiLine;
  final String roleId;

  CancleRoleDialog(
      {required this.textRole, required this.apiLine, required this.roleId});

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

  Future<void> updateTags() async {
    var _auth_service = AuthService();
    String? token = await _auth_service.getIdToken();

    List<String> selectedTags = [];
    if (genericConsult) selectedTags.add('generic');
    if (responsibilityConsult) selectedTags.add('work');
    if (relationConsult) selectedTags.add('relationship');
    if (healthConsult) selectedTags.add('health');

    var body = '';
    if (widget.apiLine == "psychiatrist") {
      body = jsonEncode({'tags': selectedTags, 'pid': widget.roleId});
    }

    var url = Uri.parse('http://${fixedIp}:3000/${widget.apiLine}/update_data');
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body);

    if (response.statusCode == 200) {
    } else if (response.statusCode == 404) {
      print("Not psychiatrist: ${response.body}");
    } else {
      print("Failed to submit data: ${response.body}");
    }
  }

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
              SizedBox(width: 5,),
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
              SizedBox(width: 5,),
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
                    updateTags();
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
                      destination: MainApp(SelectedPage: 1),
                      apiLine: widget.apiLine,
                      roleId: widget.roleId,
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
  final String apiLine;
  final String roleId;

  ConfirmDialogWithDetail(
      {required this.title,
      this.backgroundColor = ColorTheme.successAction,
      required this.destination,
      required this.apiLine,
      required this.roleId});

  @override
  _ConfirmDialogWithDetailState createState() =>
      _ConfirmDialogWithDetailState();
}

class _ConfirmDialogWithDetailState extends State<ConfirmDialogWithDetail> {
  TextEditingController descriptionTextController = TextEditingController();

  Future<void> deleteRole() async {
    var _auth_service = AuthService();
    String? token = await _auth_service.getIdToken();

    var body = '';
    if (widget.apiLine == "psychiatrist") {
      body = jsonEncode({'pid': widget.roleId});
    }

    var url = Uri.parse('http://${fixedIp}:3000/${widget.apiLine}/delete_data');
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body);

    if (response.statusCode == 200) {
    } else {
      print("No Data: ${response.body}");
    }
  }

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
                  deleteRole();
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
