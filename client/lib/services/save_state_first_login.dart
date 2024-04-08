import 'dart:ffi';

import 'package:client/services/auth_service.dart';
import 'package:client/services/ip_variable.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> setStateFirstLogin(
    BuildContext context, int firstLoginState, Widget nextPage) async {
  var _auth_service = AuthService();
  String? token = await _auth_service.getIdToken();
  var url = Uri.parse(
      'http://${fixedIp}:3000/user/save_state_first_login'); // Change to your actual endpoint
  var response = await http.post(url,
      body: json.encode({'firstloginstage': firstLoginState}),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

  if (response.statusCode == 200) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextPage,
      ),
    );
  } else {
    // Handle error
    print("Failed to submit gender: ${response.body}");
  }
}

// void _setFirstLoginStateWithToken(
//     BuildContext context, int firstLoginState, Widget nextPage) async {
//   await setStateFirstLogin(context, firstLoginState, nextPage);
//   // print(refreshEmotionsCallback);
// }
