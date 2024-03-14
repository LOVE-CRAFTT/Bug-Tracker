import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:percent_indicator/percent_indicator.dart';

TableRow buildTableRow({
  String? projectName,
  ProjectState? status,
  double? percentBugsCompleted,
  DateTime? timeCreated,
  DateTime? timeCompleted,
}) {
  /// Draw percent indicator
  LinearPercentIndicator? percentIndicator(double? percent) {
    return percent != null
        ? LinearPercentIndicator(
            percent: percent,
            center: Text(
              "${percent * 100} %",
              style: kContainerTextStyle.copyWith(
                color: Colors.black,
                fontSize: 12.0,
              ),
            ),
            lineHeight: 14.0,
            barRadius: const Radius.circular(5.0),
            backgroundColor: Colors.grey,
            progressColor: secondaryThemeColor,
          )
        : null;
  }

  return TableRow(
    children: [
      ListTile(
        title: projectName != null ? Text(projectName) : null,
        titleTextStyle: cellTextStyle,
        onTap: () {},
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
        title: percentIndicator(percentBugsCompleted),
        titleTextStyle: cellTextStyle,
        onTap: () {},
      ),
      ListTile(
        title: timeCreated != null
            ? Text(
                "${timeCreated.year}-${timeCreated.month}-${timeCreated.day}")
            : null,
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
