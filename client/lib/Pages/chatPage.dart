// ignore_for_file: sized_box_for_whitespace, file_names

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../models/models.dart';
// import '../widgets/custom_container.dart';

class ChatPage extends StatefulWidget {
  // final User user;
  // final Chat chat;

  // const ChatPage({super.key, required this.user, required this.chat});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  late String text;
  late User user;
  late Chat chat;

  @override
  void initState() {
    user = Get.arguments[0];
    chat = Get.arguments[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _CustomAppBar(
        user: user,

        // Set AppBar color to transparent
        backgroundColor: Colors.orange,
      ),
      body: Container(
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.purple,
          width: 4,
        )),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ChatMessages(
                scrollController: scrollController,
                chat: chat,
              ),
              TextFormField(
                controller: textEditingController,
                onChanged: (value) {
                  setState(() {
                    text = value;
                  });
                },
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      Theme.of(context).colorScheme.secondary.withAlpha(150),
                  hintText: 'Type here...',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(20.0),
                  suffixIcon: _buildIconButton(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: unused_element
  IconButton _buildIconButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.send),
      color: Theme.of(context).iconTheme.color,
      onPressed: () {
        Message message = Message(
          senderId: '1',
          recipientId: '2',
          text: text,
          createdAt: DateTime.now(),
        );
        List<Message> messages = List.from(chat.messages!)..add(message);
        messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        setState(() {
          chat = chat.copyWith(messages: messages);
        });
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        textEditingController.clear();
      },
    );
  }
}

// ignore: unused_element
class _ChatMessages extends StatelessWidget {
  const _ChatMessages({
    Key? key,
    required this.scrollController,
    required this.chat,
  }) : super(key: key);

  final ScrollController scrollController;
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        controller: scrollController,
        itemCount: chat.messages!.length,
        itemBuilder: (context, index) {
          Message message = chat.messages![index];
          return Align(
            alignment: (message.senderId == '1')
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.66,
              ),
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                color: (message.senderId == '1')
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                message.text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar({
    Key? key,
    required this.user,
    required this.backgroundColor,
  }) : super(key: key);

  final User user;
  final MaterialColor backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.blue,
        width: 1,
      )),
      child: AppBar(
        leading: Container(
          padding: const EdgeInsets.only(top: 70.0, left: 24.0, right: 9.0),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Image.asset(
            'lib/icons/backbutton.png',
            height: 35,
            width: 35,
            color: Colors.white,
          ),
        ),
        title: Container(
          padding: const EdgeInsets.only(top: 70.0, right: 0, left: 0),
          // width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.red,
            width: 1,
          )),
          child: Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.only(left: 0, right: 5, top: 5, bottom: 5),
                height: 61,
                width: 61,
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.green,
                  width: 1,
                )),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.imageUrl),
                ),
              ),
              const SizedBox(
                  width: 10), // Add some spacing between CircleAvatar and Text
              Container(
                padding: const EdgeInsets.only(left: 7.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green,
                    width: 1,
                  ),
                ),
                child: Text(
                  '${user.name} ${user.surname}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(top: 70.0, right: 24.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.yellow, // Choose the color you want
                width: 2.0, // Set the width of the border
              ),
            ),
            child: IconButton(
              iconSize: 35,
              icon: const Icon(Icons.phone),
              color: Colors.white, // Set the icon color
              onPressed: () {
                // Add your functionality here
              },
            ),
          ),
        ],
        // Adjust the height as needed
        automaticallyImplyLeading: false,
        // elevation: 0,
        backgroundColor: backgroundColor,
        toolbarHeight: 147,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.0), // Adjust the radius as needed
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(147);
  // @override
  // Size get preferredSize => const Size.fromHeight(147);
}


// @override
// Size get preferredSize => const Size.fromHeight(56.0);
