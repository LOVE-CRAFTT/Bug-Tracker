import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/build_table_row.dart';
import 'package:bug_tracker/ui_components/appbar.dart';

/// The discuss page is for starting conversations with individuals say for switching tasks between teams/individuals
/// Contains a button for starting new conversations, a search button, a filter button
/// and a table containing all the projects
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
                    HeaderButton(
                      screenIsWide: screenIsWide,
                      buttonText: "New Conversation",
                      onPress: () {},
                    ),

                    ///Spacing between the button and the search/filter buttons
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

                          /// The width is 40% of the screen is the screen is "wide"
                          /// Else it takes up 65%
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
                          avatarText: ['CC', 'AB'],
                          tooltipMessage: [
                            'ChukwuemekaChukwudi9',
                            'Alan Broker'
                          ],
                        ),
                        buildTableRow(
                          conversationTitle: "Review Bug",
                          projectName: 'Android Studio',
                          avatarText: ['WE'],
                          tooltipMessage: ['WindsorElizabeth'],
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

class HeaderButton extends StatelessWidget {
  const HeaderButton({
    super.key,
    required this.screenIsWide,
    required this.buttonText,
    required this.onPress,
  });

  final bool screenIsWide;
  final String buttonText;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      ///Implemented this way so the tooltip doesn't show up if the button text is already visible
      message: screenIsWide ? "" : buttonText,
      child: ElevatedButton(
        onPressed: onPress,
        style: TextButton.styleFrom(
          backgroundColor: secondaryThemeColor,
          textStyle: kContainerTextStyle,
        ),
        child: screenIsWide ? Text(buttonText) : const Text("+"),
      ),
    );
  }
}
