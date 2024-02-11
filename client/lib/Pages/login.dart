import 'package:client/Pages/signupPage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true; // Flag to toggle password visibility
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Perform login logic here
      // For simplicity, we just print the username and password for now
      print('Username: ${_usernameController.text}');
      print('Password: ${_passwordController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 93,
        backgroundColor: Colors.white,
        leading: Transform.translate(
          offset: const Offset(24, 16),
          child: GestureDetector(
            onTap: () {
              // Handle back button tap here
              Navigator.pop(context); // Navigate back to the previous screen
            },
            child:
                // Container(
                //   decoration: BoxDecoration(
                //     border: Border.all(
                //       color: Colors.red,
                //     ),
                //   ),
                //   child: const Icon(
                //     Icons.arrow_back_ios_new_rounded,
                //     size: 40,
                //     color: Colors.grey,
                //   ),
                // )
                Image.asset(
              'lib/icons/back_new.png',
              height: 10,
              width: 10,
              color: Colors.grey,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'HEALTH',
                      style: TextStyle(
                        color: Color.fromRGBO(33, 150, 243, 1),
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'MATE',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 24),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ยินดีต้อนรับค้าบบ,',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Text(
                  'เข้าสู่ระบบกัน!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, bottom: 4),
                                    child: const Text(
                                      'อีเมล',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                      color: Color(0x22212133),
                                    ),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'ใส่อีเมล',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: 24, right: 24),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, bottom: 4),
                                    child: const Text(
                                      'รหัสผ่าน',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                      color: Color(0x22212133),
                                    ),
                                    child: TextFormField(
                                      obscureText: _obscurePassword,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'ใส่รหัสผ่าน',
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                          left: 24,
                                          right: 24,
                                          top:
                                              14, // Adjust top padding as needed
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _obscurePassword =
                                                  !_obscurePassword;
                                            });
                                          },
                                          child: Icon(
                                            _obscurePassword
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'ลืมรหัสผ่าน?',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFB95000),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                                side: const BorderSide(color: Colors.orange),
                              ),
                              child: const SizedBox(
                                height: 60,
                                child: Center(
                                  child: Text(
                                    'เข้าสู่ระบบ',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'เพิ่งเคยเข้ามาใน',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                                const Text(' Health',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    )),
                                const Text(
                                  'Mate ',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const Text(
                                  'ใช่หรือไม่',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 3),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignupPage()),
                                    );
                                  },
                                  hoverColor:
                                      Colors.blue, // Set the color when hovered
                                  child: const Text(
                                    ' สมัครใหม่',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 36,
                            ),
                            Row(children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              const Text(
                                'เข้าสู่ระบบด้วย',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              ),
                            ]),
                            const SizedBox(height: 19),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Material(
                                  elevation:
                                      2.0, // Change this value to adjust the elevation
                                  shape: const CircleBorder(),
                                  child: Container(
                                    height: 55,
                                    width: 55,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: const Center(
                                      child: Image(
                                        image:
                                            AssetImage('lib/icons/google.png'),
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Material(
                                  elevation:
                                      2.0, // Change this value to adjust the elevation
                                  shape: CircleBorder(),
                                  child: SizedBox(
                                    height: 55,
                                    width: 55,
                                    child: Center(
                                      child: Image(
                                        image:
                                            AssetImage('lib/icons/apple.png'),
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Material(
                                  elevation:
                                      2.0, // Change this value to adjust the elevation
                                  shape: const CircleBorder(),
                                  child: Container(
                                    height: 55,
                                    width: 55,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: const Center(
                                      child: Image(
                                        image: AssetImage(
                                            'lib/icons/facebook.png'),
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 41),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'การเข้าสู่ระบบหรือสร้างบัญชีแสดงว่าคุณยอมรับ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'ข้อกำหนดและเงื่อนไข',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.orange, // Set to orange
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' และ ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black, // Set to black
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'นโยบายความเป็นส่วนตัว',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.orange, // Set to orange
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
