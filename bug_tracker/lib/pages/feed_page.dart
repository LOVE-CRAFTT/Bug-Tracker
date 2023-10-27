import 'package:bug_tracker/utilities/constants.dart';
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
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15, right: 20),
                child: Material(
                  shape: CircleBorder(),
                  color: Colors.grey,
                  child: IconButton(
                    onPressed: null,
                    tooltip: "ChukwuemekaChukwudi9",
                    icon: Icon(Icons.account_circle_outlined),
                  ),
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    var rightPadding =
                        constraints.maxWidth > 550 ? 150.0 : 50.0;
                    return Padding(
                      padding: EdgeInsets.only(right: rightPadding),
                      child: TextField(
                        style: kContainerTextStyle.copyWith(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: "Start a discussion",
                          hintStyle: kContainerTextStyle.copyWith(
                              color: Colors.black45),
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white70,
                        ),
                        onChanged: (text) {},
                        onSubmitted: (submitText) {},
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 1200,
          )
        ],
      ),
    );
  }
}
