import 'package:flutter/material.dart';

void main() {
  runApp(ProfilePage());
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Profile Page"),
        ),
        body: ProfilePageBody(),
      ),
    );
  }
}


class ProfilePageBody extends StatelessWidget {
  const ProfilePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Center(
        child: Text(
          "Welcome!",
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}