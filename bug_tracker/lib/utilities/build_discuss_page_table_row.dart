import 'package:bug_tracker/admin_pages/conversation_page.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

/// Build Table Rows in the discuss page
/// Parameters are all named and optional and they include
/// [firstHeader] => the header of the first column
/// [secondHeader] => the header of the second column
/// conversationTitle, tooltipMessage and avatarText and the backgroundImage
TableRow buildTableRow({
  String? firstHeader,
  String? secondHeader,
  String? conversationTitle,
  List<String>? avatarText,
  List<String>? tooltipMessage,
  String? backgroundImage,
  required BuildContext context,
}) {
  TextStyle cellTextStyle = kContainerTextStyle.copyWith(fontSize: 14.0);

  return TableRow(
    children: [
      ListTile(
        /// Creates the conversation title and makes it clickable if it is not the first column title
        /// else it is just text containing the first header
        title: Text(firstHeader ?? (conversationTitle ?? "Null Value")),
        titleTextStyle: cellTextStyle,
        onTap: firstHeader == null
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConversationPage(),
                  ),
                );
              }
            : null,
      ),
      ListTile(
        /// Creates a list of circle avatars if it is not the second column title
        /// else it just text containing the second header
        title: secondHeader == null
            ? SizedBox(
                height: 50.0,
                child: ListView.builder(
                  itemCount: avatarText?.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final String? lAvatarMessage = avatarText?[index];
                    final String? lTooltipMessage = tooltipMessage?[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Tooltip(
                        message: lTooltipMessage,
                        child: avatarText != null
                            ? CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: lAvatarMessage != null
                                    ? Text(lAvatarMessage)
                                    : const Text("Error Value"),
                              )
                            : null,
                      ),
                    );
                  },
                ),
              )
            : Text(secondHeader),
        titleTextStyle: cellTextStyle,
      )
    ],
  );
}
