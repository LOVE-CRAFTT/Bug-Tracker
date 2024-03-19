import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  /// add Leave conversation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericTaskBar("Conversation"),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(),
          );
        },
      ),
    );
  }
}
