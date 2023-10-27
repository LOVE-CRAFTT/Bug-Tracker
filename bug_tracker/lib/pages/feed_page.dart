import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/appbar.dart';
import 'package:bug_tracker/ui_components/feed_page_choice_button.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  String? dropDownValue = choices.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar("Feed"),
      body: ListView(
        children: [
          Column(
            children: [
              FeedChoiceButton(
                  dropDownValue: dropDownValue,
                  onChanged: (selected) {
                    setState(() {
                      dropDownValue = selected;
                    });
                  }),
            ],
          )
        ],
      ),
    );
  }
}
