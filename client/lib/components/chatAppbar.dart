// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../models/models.dart'; // Make sure to adjust the import path based on your project structure
// Make sure to adjust the import path based on your project structure

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.user,
    this.backgroundColor = Colors.orange,
  });

  final User? user;
  final MaterialColor backgroundColor;

  @override
  Widget build(BuildContext context) {
    final userImageUrl = user?.imageUrl ?? '';

    return AppBar(
        elevation: 15,
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              padding: const EdgeInsets.only(left: 24.0, bottom: 16),
              child: Container(
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: Colors.white,
                //   ),
                // ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // decoration: BoxDecoration(
                      //   border: Border.all(color: Colors.grey, width: 4),
                      // ),
                      padding: const EdgeInsets.only(right: 12),
                      child: Row(
                        children: [
                          Container(
                            //back button
                            padding: const EdgeInsets.all(0),
                            // decoration: BoxDecoration(
                            //   border: Border.all(
                            //     color: Colors.red,
                            //   ),
                            // ),
                            child: Image.asset(
                              'lib/icons/back_new.png',
                              height: 50,
                              width: 50,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            //user image
                            padding: const EdgeInsets.all(5),
                            // decoration: BoxDecoration(
                            //   border: Border.all(
                            //     color: Colors.blue,
                            //   ),
                            // ),
                            height: 60,
                            width: 60,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(userImageUrl),
                            ),
                          ),
                          Container(
                            width: 12,
                          ),
                          Container(
                            //user name
                            width: 120,
                            height: 46,
                            // decoration: BoxDecoration(
                            //   border: Border.all(
                            //     color: Colors.yellow,
                            //   ),
                            // ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    // '${user?.name}',
                                    'Volunteer A25',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    )),
                                Text('ออนไลน์',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF219EBC),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 24),
                      // decoration: BoxDecoration(
                      //   border: Border.all(
                      //     color: Colors.green,
                      //   ),
                      // ),
                      child: SizedBox(
                        //phone button
                        height: 35,
                        width: 35,
                        // decoration: BoxDecoration(
                        //   border: Border.all(
                        //     color: Colors.purple,
                        //   ),
                        // ),
                        child: Image.asset(
                          'lib/icons/phonecall-button.png',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  @override
  Size get preferredSize => const Size.fromHeight(147);
}
