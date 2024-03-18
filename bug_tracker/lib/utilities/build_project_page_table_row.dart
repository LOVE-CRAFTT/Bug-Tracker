import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/project.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/ui_components/custom_linear_percent_indicator.dart';

TableRow buildTableRow({
  required BuildContext context,
  required Project project,
  required double percentBugsCompleted,
}) {
  /// Draw percent indicator

  return TableRow(
    children: [
      ListTile(
        title: Text(project.id.toString()),
        titleTextStyle: cellTextStyle,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Placeholder(),
            ),
          );
        },
      ),
      ListTile(
        title: Text(project.name),
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Chip(
            label: Text(
              project.state.title,
              style: kContainerTextStyle.copyWith(color: Colors.black),
            ),
            backgroundColor: project.state.associatedColor,
          ),
        ),
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: percentIndicator(percentBugsCompleted),
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: Text(convertToDateString(project.dateCreated)),
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: project.dateClosed != null
            ? Text(
                convertToDateString(project.dateClosed!),
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
    "PROJECT ID",
    "PROJECT",
    "STATUS",
    "BUGS",
    "CREATED",
    "COMPLETED",
  ];

  return headerNames
      .map((header) => ListTile(
            title: Text(header),
            titleTextStyle: cellTextStyle,
          ))
      .toList();
}
