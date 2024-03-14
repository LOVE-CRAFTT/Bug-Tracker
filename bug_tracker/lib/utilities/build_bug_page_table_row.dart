import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

TableRow buildTableRow({
  required int bugID,
  required String bugName,
  required String projectName,
  required String reporter,
  required DateTime timeCreated,
  String? assignee,
  List<Tags>? tags,
  required ComplaintState status,
}) {
  return TableRow(
    children: [
      ListTile(
        title: Text(bugID.toString()),
        titleTextStyle: cellTextStyle,
        onTap: () {},
      ),
      ListTile(
        title: Text(bugName),
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: Text(projectName),
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: Text(reporter),
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title:
            Text("${timeCreated.year}-${timeCreated.month}-${timeCreated.day}"),
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Chip(
            label: Text(
              status.title,
              style: kContainerTextStyle.copyWith(color: Colors.black),
            ),
            backgroundColor: status.associatedColor,
          ),
        ),
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
    "BUG ID",
    "BUG",
    "PROJECT",
    "REPORTER",
    "CREATED",
    "STATUS",
    "ASSIGNEE",
    "TAGS",
  ];

  return headerNames
      .map((header) => ListTile(
            title: Text(header),
            titleTextStyle: cellTextStyle,
          ))
      .toList();
}
