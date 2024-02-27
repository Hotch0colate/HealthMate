import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON encoding
import 'package:http/http.dart' as http; // HTTP package
import 'package:intl/intl.dart';

//page import
import 'package:client/pages/authentication/first_login/first_login_1.dart';
import 'package:client/pages/authentication/first_login/first_login_3.dart';

//component import
import '../../../component/buttons.dart';

class FirstLogin2 extends StatefulWidget {
  const FirstLogin2({Key? key}) : super(key: key);

  @override
  _FirstLogin2State createState() => _FirstLogin2State();
}

class _FirstLogin2State extends State<FirstLogin2> {
  bool agreedToTerms = false;
  String selectedGender = ''; // Variable to store selected gender
  TextEditingController birthDateController =
      TextEditingController(); // Controller for birth date input

  Future<void> sendUserDataToBackend() async {
    Uri apiUrl = Uri.parse(
        'http://localhost:3000/user/update_data'); // Replace with your backend API endpoint
    try {
      var response = await http.post(
        apiUrl,
        body: json.encode({
          'birthDate': birthDateController
              .text, // Assuming you want to send the birth date
          // Add other data you might want to send here
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Handle success
        print('Data sent successfully');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FirstLogin3(),
          ),
        );
      } else {
        // Handle error
        print('Failed to send data');
      }
    } catch (e) {
      print('Error sending data: $e');
    }
  }

  DateTime? selectedDate;
  TextEditingController dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ??
          DateTime.now(), // Use the current date if no date is selected
      firstDate: DateTime(2000), // Adjust the starting date as per requirement
      lastDate: DateTime(2025), // Adjust the ending date as per requirement
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // Update the text field with the selected date formatted as DD/MM/YYYY
        dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 51,
                  width: MediaQuery.of(context).size.width - 32,
                ),
                Image.asset('assets/logos/big_app_name.png'),
                const SizedBox(
                  height: 37,
                ),
                const SizedBox(
                  height: 86,
                  child: Image(
                    image: AssetImage(
                      'assets/logos/main_mascot.png',
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'วันเกิดคุณคือวันไหนครับ ?',
                  style: TextStyle(
                      color: Color.fromRGBO(251, 133, 0, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 26.5),
                const Text(
                  'คำตอบของคุณ: ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins'),
                ),
                // Radio buttons for gender selection
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: TextFormField(
                    controller: dateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(34, 33, 33, 0.6),
                          width: 2,
                        ),
                      ),
                      hintText: 'DD/MM/YYYY',
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(34, 33, 33, 0.6),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context),
                        color: Color.fromRGBO(34, 33, 33, 0.6),
                      ),
                    ),
                    readOnly:
                        true, // Prevents keyboard from appearing when tapping the field
                  ),
                ),
                const SizedBox(height: 242),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GoBackButton(
                      onPressed: () {
                        // Your navigation or functionality here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const FirstLogin1(), // Example: Navigate to a specific screen
                          ),
                        );
                      },
                    ),
                    ForwardButton(
                      onPressed: () {
                        sendUserDataToBackend();
                        // Handle button press for the left button
                        // You can add your logic or navigation here
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}