import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// ignore: unused_import
import 'Pages/pages.dart';
// import 'components/chatAppbar.dart';
import 'Pages/login.dart';
import 'Pages/signupPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NavigationExample(),
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
        });
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: 'Health',
                style: TextStyle(
                  color: Color.fromRGBO(
                      33, 158, 188, 1), // Set the color for 'Health'
                ),
              ),
              TextSpan(
                text: 'Mate',
                style: TextStyle(
                  color: Color.fromRGBO(
                      251, 133, 0, 1), // Set the color for 'Mate'
                ),
              ),
            ],
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        leadingWidth: 10,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Color.fromARGB(255, 255, 149, 68),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.calendar_month),
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calendar',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.phone_in_talk),
            icon: Icon(Icons.phone_in_talk_outlined),
            label: 'Talk',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.chat_bubble),
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.chat_bubble_outline),
            ),
            label: 'Messages',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        /// Calendar page
        const Card(
          margin: EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text('Calendar'),
            ),
          ),
        ),

        /// Select to talk page
        Card(
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                      height:
                          20), // Adjust the spacing between 'Talk' and the boxes

                  // First Box
                  Container(
                    width: 342,
                    height: 223,
                    color: const Color.fromRGBO(151, 229, 206, 0.4),
                    margin: const EdgeInsets.all(8.0),
                  ),

                  // Second Box
                  Container(
                    width: 342,
                    height: 223,
                    color: const Color.fromRGBO(255, 202, 69, 0.4),
                    margin: const EdgeInsets.all(8.0),
                  ),
                ],
              ),
            ),
          ),
        ),

        /// Messages page
        DefaultTabController(
          length: 2, // Number of tabs
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'ทั้งหมด'),
                  Tab(text: 'ยังไม่ได้อ่าน'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                // All Chats
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: SizedBox.expand(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: const CircleAvatar(
                                    backgroundImage: AssetImage('####'),
                                  ),
                                  title: Text('อาสาสมัคร ${index + 1}'),
                                  subtitle: const Text('สวัสดีเป็นไงบ้าง'),
                                  // Add onTap handler or other customization as needed
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Filtered Chats
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: SizedBox.expand(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: 2, // Add your filtered chat logic here
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: const CircleAvatar(
                                    backgroundImage: AssetImage('####'),
                                  ),
                                  title: Text('อาสาสมัคร ${index + 1}'),
                                  subtitle: const Text('สบายดีค่ะ'),
                                  trailing: const Icon(Icons
                                      .mark_unread_chat_alt), // Add "unread" icon
                                  // Add onTap handler or other customization as needed
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        /// Profile page
        const Card(
          shadowColor: Colors.transparent,
          margin: EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text('Profile'),
            ),
          ),
        ),
      ][currentPageIndex],
    );
  }
}

class ChatPage extends StatelessWidget {
  final String personName;

  ChatPage({required this.personName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with $personName'),
      ),
      body: Center(
        child: Text('Chat content goes here...'),
      ),
    );
  }
}
