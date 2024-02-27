import 'package:flutter/material.dart';

void main() {
  runApp(SelectTalk());
}

class SelectTalk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select talk Page"),
      ),
      body: SelectTalkPageBody(),
    );
  }
}

class SelectTalkPageBody extends StatelessWidget {
  const SelectTalkPageBody({super.key});

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
