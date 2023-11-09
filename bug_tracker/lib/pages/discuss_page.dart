import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/page_functions.dart';
import 'package:bug_tracker/ui_components/appbar.dart';

class DiscussPage extends StatefulWidget {
  const DiscussPage({super.key});

  @override
  State<DiscussPage> createState() => _DiscussPageState();
}

class _DiscussPageState extends State<DiscussPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar("Discuss"),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var screenIsWide = constraints.maxWidth > 400;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Row(
                  children: [
                    Tooltip(
                      message: screenIsWide ? "" : "New Conversation",
                      child: ElevatedButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: secondaryThemeColor,
                          textStyle: kContainerTextStyle,
                        ),
                        child: screenIsWide
                            ? const Text("New Conversation")
                            : const Text("+"),
                      ),
                    ),
                    if (screenIsWide) Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10.0,
                      ),
                      child: SearchBar(
                        leading: const Icon(Icons.search),
                        padding: const MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        ),
                        constraints: BoxConstraints(
                          maxHeight: 56.0,
                          maxWidth: screenIsWide
                              ? constraints.maxWidth * 0.4
                              : constraints.maxWidth * 0.65,
                        ),
                        textStyle: const MaterialStatePropertyAll<TextStyle>(
                          kContainerTextStyle,
                        ),
                        onSubmitted: (target) {},
                        onChanged: (input) {},
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_alt_outlined),
                      tooltip: "Filter",
                      splashRadius: 20.0,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: DefaultTextStyle(
                    style: kContainerTextStyle.copyWith(fontSize: 14.0),
                    child: Table(
                      border: const TableBorder(
                        horizontalInside: BorderSide(
                          color: Color(0xFF979c99),
                        ),
                      ),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        buildTableRow(
                          firstHeader: "CONVERSATION",
                          secondHeader: "PROJECT",
                          thirdHeader: "PARTICIPANTS",
                        ),
                        buildTableRow(
                          conversationTitle: "New Sales Data",
                          projectName: 'Origami Algorithm',
                          tooltipMessage: 'ChukwuemekaChukwudi9',
                          avatarText: 'CC',
                        ),
                        buildTableRow(
                          conversationTitle: "Review Bug",
                          projectName: 'Android Studio',
                          tooltipMessage: 'WindsorElizabeth',
                          avatarText: 'WE',
                        ),
                      ],
                    ),
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
