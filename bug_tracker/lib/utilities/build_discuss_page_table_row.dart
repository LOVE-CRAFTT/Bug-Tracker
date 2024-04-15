import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/discuss.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/staff_pages/messages_page.dart';

/// Build Table Rows in the discuss page
TableRow buildTableRow({
  required Discuss discussion,
  required BuildContext context,
}) {
  TextStyle cellTextStyle = kContainerTextStyle.copyWith(fontSize: 14.0);

  return TableRow(
    children: [
      ListTile(
        title: Text(discussion.title),
        titleTextStyle: cellTextStyle,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MessagesPage(discussionID: discussion.id),
            ),
          );
        },
      ),
      ListTile(
        title: SizedBox(
          height: 50.0,
          child: ListView.builder(
            itemCount: discussion.participants.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final String lAvatarMessage =
                  discussion.participants[index].initials;
              final String lTooltipMessage = getFullNameFromNames(
                surname: discussion.participants[index].surname,
                firstName: discussion.participants[index].firstName,
                middleName: discussion.participants[index].middleName,
              );

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
    "TOPIC",
    "PARTICIPANTS",
  ];

  return headerNames
      .map((header) => ListTile(
            title: Text(header),
            titleTextStyle: kContainerTextStyle.copyWith(fontSize: 14.0),
          ))
      .toList();
}
