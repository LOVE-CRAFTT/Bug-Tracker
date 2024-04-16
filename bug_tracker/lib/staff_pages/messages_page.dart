import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/retrieve_messages.dart';
import 'package:bug_tracker/models/discussion_updates.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/ui_components/message_bubble.dart';
import 'package:bug_tracker/ui_components/custom_circular_progress_indicator.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key, required this.discussionID});
  final int discussionID;

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final messageTextController = TextEditingController();
  final scrollController = ScrollController();

  int limit = 40;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      // if user has scrolled to the top load more
      if (scrollController.position.pixels == 0) {
        limit += 20;
        setState(() {});
      }
    });

    // scroll to end at first
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // watch for when new messages are added
    context.watch<MessageUpdates>();
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
                  child: FutureBuilder(
                    future: retrieveMessages(
                        discussionID: widget.discussionID, limit: limit),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<MessageBubble>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CustomCircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data!.length,
                          controller: scrollController,
                          itemBuilder: (BuildContext context, int index) {
                            return snapshot.data![index];
                          },
                        );
                      }
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
                          if (messageTextController.text.trim().isEmpty) {
                            messageTextController.clear();
                          } else {
                            context.read<MessageUpdates>().addMessage(
                                  senderID: globalActorID,
                                  discussionID: widget.discussionID,
                                  message: messageTextController.text,
                                );
                            messageTextController.clear();
                          }
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
