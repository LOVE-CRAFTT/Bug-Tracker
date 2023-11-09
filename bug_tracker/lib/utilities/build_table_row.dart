import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

/// Build Table Rows in the discuss page
/// Parameters are all named and optional and they include
/// [firstHeader] => the header of the first column
/// [secondHeader] => the header of the second column
/// [thirdHeader] => the header of the first column
/// conversationTitle, projectName, tooltipMessage and avatarText and the backgroundImage
TableRow buildTableRow({
  String? firstHeader,
  String? secondHeader,
  String? thirdHeader,
  String? conversationTitle,
  String? projectName,
  String? tooltipMessage,
  String? avatarText,
  String? backgroundImage,
}) {
  TextStyle cellTextStyle = kContainerTextStyle.copyWith(fontSize: 14.0);

  return TableRow(
    children: [
      ListTile(
        /// Creates an Icon button, conversation title and makes it clickable if it is not the first column title
        /// else it is just text containing the first header
        leading: firstHeader == null
            ? IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  color: secondaryThemeColor,
                  size: 15.0,
                ),
              )
            : null,
        title: Text(firstHeader ?? (conversationTitle ?? "Null Value")),
        titleTextStyle: cellTextStyle,
        onTap: firstHeader == null ? () {} : null,
      ),
      ListTile(
        /// Creates a project name and makes it clickable if it not the second column title
        /// else it is just text containing the second header
        title: Text(secondHeader ?? (projectName ?? "Error Value")),
        titleTextStyle: cellTextStyle,
        onTap: secondHeader == null ? () {} : null,
      ),
      ListTile(
        /// Creates a list of circle avatars if it is not the third column title
        /// else it just text containing the third header
        title: thirdHeader != null ? Text(thirdHeader) : null,
        titleTextStyle: cellTextStyle,
        leading: thirdHeader != null
            ? null
            : Tooltip(
                message: tooltipMessage,
                child: avatarText != null
                    ? CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Text(avatarText),
                      )
                    : null,
              ),
      )
    ],
  );
}
