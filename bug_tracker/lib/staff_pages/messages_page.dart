import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/ui_components/message_bubble.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key, required this.discussionID});
  final int discussionID;

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final messageTextController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // scroll to end at first
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericTaskBar("Messages"),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 50,
                    controller: scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      return MessageBubble(
                          sender: "me",
                          text: "mini me==========\nrre testing",
                          isMe: (index % 2 == 0) ? true : false);
                    },
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageTextController,
                          onChanged: (value) {},
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ),
                            hintText: 'Type your message here...',
                            hintStyle: kContainerTextStyle,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      HeaderButton(
                        screenIsWide: true,
                        buttonText: "Send",
                        onPress: () {
                          /// add to db
                          messageTextController.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
