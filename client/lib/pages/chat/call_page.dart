import 'package:client/component/buttons.dart';
import 'package:client/pages/psychiar_register/attach_cert.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthMate',
      home: DetailUserPage(),
    );
  }
}

class DetailUserPage extends StatefulWidget {
  const DetailUserPage({super.key});

  @override
  State<DetailUserPage> createState() => _DetailUserPageState();
}

class _DetailUserPageState extends State<DetailUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            // Wrap with SingleChildScrollView
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios, // Replace with your custom icon
                              color: Colors.black38,
                              size: 30, // Customize the icon color
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorTheme.primaryColor.withOpacity(0.7),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/avatar/md_10.png',
                            width: 150, // Adjust the width as needed
                            height: 150, // Adjust the height as needed
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Volunteer 25',
                        style: FontTheme.subtitle1,
                      ),
                      Text(
                        'ออนไลน์',
                        style: FontTheme.btn_small.copyWith(color: ColorTheme.successAction),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MdPrimaryButton(
                        text: 'จบการสนทนา',
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AttachCertificate()),
                );
              },
              child: Text(
                'รายงานผู้ใช้ ?',
                textAlign: TextAlign.center,
                style: FontTheme.btn_small.copyWith(color: ColorTheme.errorAction),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
