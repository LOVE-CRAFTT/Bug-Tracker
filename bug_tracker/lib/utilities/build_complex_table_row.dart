import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

TableRow buildTableRow({
  String? bugName,
  String? projectName,
  String? reporter,
  DateTime? timeCreated,
  String? assignee,
  List<Tags>? tags,
  DateTime? dueDate,
  Status? status,
}) {
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
      ListTile(
        title: assignee != null ? Text(assignee) : null,
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: dueDate != null
            ? Text("${dueDate.year}-${dueDate.month}-${dueDate.day}")
            : null,
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: tags != null
            ? Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 50.0,
                  child: ListView.builder(
                    itemCount: tags.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Chip(
                          label: Text(
                            tags[index].title,
                            style: kContainerTextStyle.copyWith(
                                color: Colors.black),
                          ),
                          backgroundColor: tags[index].associatedColor,
                        ),
                      );
                    },
                  ),
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
  testing(title: "Testing", associatedColor: Colors.blue),
  closed(title: "Closed", associatedColor: Colors.green),
  open(title: "Open", associatedColor: Colors.red),
  postponed(title: "Postponed", associatedColor: Colors.orange),
  inProgress(title: "In Progress", associatedColor: Colors.yellow),
  verified(title: "Verified", associatedColor: Colors.teal),
  wontFix(title: "Won't Fix", associatedColor: Colors.grey);

  const Status({required this.title, required this.associatedColor});
  final String title;
  final Color associatedColor;
}

enum Tags {
  ui(title: "UI", associatedColor: Colors.pink),
  functionality(title: "Functionality", associatedColor: Colors.brown),
  performance(title: "Performance", associatedColor: Colors.cyan),
  security(title: "Security", associatedColor: customMaroon),
  database(title: "Database", associatedColor: customOlive),
  network(title: "Network", associatedColor: Colors.lime);

  const Tags({required this.title, required this.associatedColor});
  final String title;
  final Color associatedColor;

  static const Color customMaroon = Color(0xFF800000);
  static const Color customOlive = Color(0xFF808000);
}
