import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

/// Build Table Rows in the discuss page
/// Parameters are all named and optional and they include
/// [firstHeader] => the header of the first column
/// [secondHeader] => the header of the second column
/// [thirdHeader] => the header of the first column
/// conversationTitle, projectName, tooltipMessage and avatarText and the backgroundImage
TableRow buildTableRow({
  String? bugName,
  String? projectName,
  String? reporter,
  DateTime? timeCreated,
  String? assignee,
  Tags? tags,
  DateTime? dueDate,
  Status? status,
}) {
  ///7 headers
  return TableRow(
    children: [
      ListTile(
        title: bugName != null ? Text(bugName) : null,
        titleTextStyle: cellTextStyle,
        onTap: () {},
      ),
      ListTile(
        title: projectName != null ? Text(projectName) : null,
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: reporter != null ? Text(reporter) : null,
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: timeCreated != null
            ? Text(
                "${timeCreated.year}-${timeCreated.month}-${timeCreated.day}")
            : null,
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: assignee != null ? Text(assignee) : null,
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: tags != null
            ? Align(
                alignment: Alignment.centerLeft,
                child: Chip(
                  label: Text(
                    tags.title,
                    style: kContainerTextStyle.copyWith(color: Colors.black),
                  ),
                  backgroundColor: tags.associatedColor,
                ),
              )
            : null,
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: dueDate != null
            ? Text("${dueDate.year}-${dueDate.month}-${dueDate.day}")
            : null,
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: status != null
            ? Align(
                alignment: Alignment.centerLeft,
                child: Chip(
                  label: Text(
                    status.title,
                    style: kContainerTextStyle.copyWith(color: Colors.black),
                  ),
                  backgroundColor: status.associatedColor,
                ),
              )
            : null,
        titleTextStyle: cellTextStyle,
      ),
    ],
  );
}

TextStyle cellTextStyle = kContainerTextStyle.copyWith(fontSize: 14.0);

List<ListTile> buildTableHeaders() {
  List<String> headerNames = [
    "BUG",
    "PROJECT",
    "REPORTER",
    "CREATED",
    "ASSIGNEE",
    "TAGS",
    "DUE DATE",
    "STATUS",
  ];

  return headerNames
      .map((header) => ListTile(
            title: Text(header),
            titleTextStyle: cellTextStyle,
          ))
      .toList();
}

enum Status {
  testing(title: "testing", associatedColor: Colors.blue),
  closed(title: "closed", associatedColor: Colors.green),
  open(title: "open", associatedColor: Colors.red),
  postponed(title: "postponed", associatedColor: Colors.orange),
  inProgress(title: "in Progress", associatedColor: Colors.yellow),
  verified(title: "verified", associatedColor: Colors.teal),
  wontFix(title: "won't Fix", associatedColor: Colors.grey);

  const Status({required this.title, required this.associatedColor});
  final String title;
  final Color associatedColor;
}

enum Tags {
  ui(title: "ui", associatedColor: Colors.pink),
  functionality(title: "functionality", associatedColor: Colors.brown),
  performance(title: "performance", associatedColor: Colors.cyan),
  security(title: "security", associatedColor: customMaroon),
  database(title: "database", associatedColor: customOlive),
  network(title: "network", associatedColor: Colors.lime);

  const Tags({required this.title, required this.associatedColor});
  final String title;
  final Color associatedColor;

  static const Color customMaroon = Color(0xFF800000);
  static const Color customOlive = Color(0xFF808000);
}
