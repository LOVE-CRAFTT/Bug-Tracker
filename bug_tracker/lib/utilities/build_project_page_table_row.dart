import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/custom_linear_percent_indicator.dart';

TableRow buildTableRow({
  required int projectID,
  required String projectName,
  required ProjectState status,
  required double percentBugsCompleted,
  required DateTime timeCreated,
  DateTime? timeCompleted,
}) {
  /// Draw percent indicator

  return TableRow(
    children: [
      ListTile(
        title: Text(projectID.toString()),
        titleTextStyle: cellTextStyle,
        onTap: () {},
      ),
      ListTile(
        title: Text(projectName),
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
        title: percentIndicator(percentBugsCompleted),
        titleTextStyle: cellTextStyle,
        onTap: () {},
      ),
      ListTile(
        title:
            Text("${timeCreated.year}-${timeCreated.month}-${timeCreated.day}"),
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: timeCompleted != null
            ? Text(
                "${timeCompleted.year}-${timeCompleted.month}-${timeCompleted.day}")
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
