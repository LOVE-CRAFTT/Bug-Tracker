import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/build_discuss_page_table_row.dart';
import 'package:bug_tracker/ui_components/staff_appbar.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:bug_tracker/staff_pages/new_conversation_page.dart';

/// The discuss page is for starting conversations with individuals say for switching tasks between teams/individuals
/// Contains a button for starting new conversations and a search button
class DiscussPage extends StatefulWidget {
  const DiscussPage({super.key});

  @override
  State<DiscussPage> createState() => _DiscussPageState();
}

class _DiscussPageState extends State<DiscussPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: staffReusableAppBar("Discuss", context),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var screenIsWide = constraints.maxWidth > 400;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeaderButton(
                      screenIsWide: screenIsWide,
                      buttonText: "New Conversation",
                      onPress: () {
                        SideSheet.right(
                          context: context,
                          width: constraints.maxWidth * 0.7,
                          sheetColor: lightAshyNavyBlue,
                          sheetBorderRadius: 10.0,
                          body: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: NewConversation(
                              constraints: constraints,
                            ),
                          ),
                        );
                      },
                    ),
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
                        hintText: "Search Discussions",
                        hintStyle: const MaterialStatePropertyAll<TextStyle>(
                          kContainerTextStyle,
                        ),
                        textStyle: MaterialStatePropertyAll<TextStyle>(
                          kContainerTextStyle.copyWith(color: Colors.white),
                        ),
                        onSubmitted: (target) {},
                        onChanged: (input) {},
                      ),
                    ),
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
                          secondHeader: "PARTICIPANTS",
                          context: context,
                        ),
                        buildTableRow(
                          conversationTitle: "New Sales Data",
                          avatarText: ['CC', 'AB'],
                          tooltipMessage: [
                            'ChukwuemekaChukwudi9',
                            'Alan Broker'
                          ],
                          context: context,
                        ),
                        buildTableRow(
                          conversationTitle: "Review Bug",
                          avatarText: ['WE'],
                          tooltipMessage: ['WindsorElizabeth'],
                          context: context,
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
