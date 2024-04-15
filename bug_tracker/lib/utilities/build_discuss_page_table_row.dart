import 'package:bug_tracker/staff_pages/conversation_page.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

/// Build Table Rows in the discuss page
TableRow buildTableRow({
  required String conversationTitle,
  required List<String> avatarText,
  required List<String> tooltipMessage,
  required BuildContext context,
}) {
  TextStyle cellTextStyle = kContainerTextStyle.copyWith(fontSize: 14.0);

  return TableRow(
    children: [
      ListTile(
        title: Text(conversationTitle),
        titleTextStyle: cellTextStyle,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ConversationPage(),
            ),
          );
        },
      ),
      ListTile(
        title: SizedBox(
          height: 50.0,
          child: ListView.builder(
            itemCount: avatarText.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final String lAvatarMessage = avatarText[index];
              final String lTooltipMessage = tooltipMessage[index];
              return Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Tooltip(
                  message: lTooltipMessage,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Text(lAvatarMessage),
                  ),
                ),
              );
            },
          ),
        ),
        titleTextStyle: cellTextStyle,
      )
    ],
  );
}

List<ListTile> buildTableHeaders() {
  List<String> headerNames = [
    "DISCUSSION",
    "PARTICIPANTS",
  ];

  return headerNames
      .map((header) => ListTile(
            title: Text(header),
            titleTextStyle: kContainerTextStyle.copyWith(fontSize: 14.0),
          ))
      .toList();
}
