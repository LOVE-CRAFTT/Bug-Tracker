import 'package:bug_tracker/utilities/constants.dart';
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
  final spacingHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: reusableAppBar("Feed"),
        body: ListView(
          children: [
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FeedChoiceButton(
                      dropDownValue: dropDownValue,
                      onChanged: (selected) {
                        setState(() {
                          dropDownValue = selected;
                        });
                      },
                      constraints: constraints,
                    ),
                    SizedBox(
                      height: spacingHeight,
                    ),
                    DiscussionTextField(
                      constraints: constraints,
                    ),
                    SizedBox(
                      height: spacingHeight,
                    ),
                    DefaultTextStyle(
                      style: kContainerTextStyle,
                      child: TabBar(
                        tabs: const [
                          Text("Feed"),
                          Text("Status"),
                          Text("Activity Stream"),
                        ],
                        indicatorColor: const Color(0xFFFF6400),
                        padding: EdgeInsets.only(
                          //IconButton width is 45
                          left: 75,
                          right: constraints.maxWidth > 550 ? 150.0 : 50.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 600,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 75.0,
                          right: constraints.maxWidth > 550 ? 150.0 : 50.0,
                          top: spacingHeight,
                        ),
                        child: const TabBarView(
                          children: [
                            Placeholder(),
                            Placeholder(),
                            Placeholder(),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
