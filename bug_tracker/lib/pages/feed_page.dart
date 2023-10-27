import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/appbar.dart';
import 'package:bug_tracker/ui_components/feed_page_choice_button.dart';
import 'package:bug_tracker/ui_components/feed_page_text_field.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  String? dropDownValue = choices.first;
  final biggerSpacingHeight = 50.0;
  final smallerSpacingHeight = 30.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar("Feed"),
      body: ListView(
        children: [
          FeedChoiceButton(
            dropDownValue: dropDownValue,
            onChanged: (selected) {
              setState(() {
                dropDownValue = selected;
              });
            },
          ),
          SizedBox(
            height: biggerSpacingHeight,
          ),
          const DiscussionTextField(),
          SizedBox(
            height: smallerSpacingHeight,
          ),
          const SizedBox(
            height: 1200,
          )
        ],
      ),
    );
  }
}
