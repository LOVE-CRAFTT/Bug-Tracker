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
    "STATUS",
    "ASSIGNEE",
    "DUE DATE",
    "TAGS",
  ];

  return headerNames
      .map((header) => ListTile(
            title: Text(header),
            titleTextStyle: cellTextStyle,
          ))
      .toList();
}
