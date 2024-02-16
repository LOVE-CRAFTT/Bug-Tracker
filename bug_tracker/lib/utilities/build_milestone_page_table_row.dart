import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:percent_indicator/percent_indicator.dart';

TableRow buildTableRow({
  String? milestone,
  String? projectName,
  double? percentBugsCompleted,
  DateTime? timeCreated,
  String? owner,
  List<Tags>? tags,
  DateTime? dueDate,
  Status? status,
}) {
  return TableRow(
    children: [
      ListTile(
        title: milestone != null ? Text(milestone) : null,
        titleTextStyle: cellTextStyle,
        onTap: () {},
      ),
      ListTile(
        title: projectName != null ? Text(projectName) : null,
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: percentBugsCompleted != null
            ? LinearPercentIndicator(
                percent: percentBugsCompleted,
                center: Text(
                  "${percentBugsCompleted * 100} %",
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
            : null,
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
        title: owner != null ? Text(owner) : null,
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
                              color: Colors.black,
                            ),
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
    "MILESTONE",
    "PROJECT",
    "BUGS",
    "CREATED",
    "OWNER",
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
