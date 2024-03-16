import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/ui_components/custom_linear_percent_indicator.dart';
import 'package:bug_tracker/admin_pages/bug_detail_page.dart';

TableRow buildTableRow({
  required BuildContext context,
  required Complaint complaint,
  required double percentCompleted,
  String? assignee,
}) {
  return TableRow(
    children: [
      ListTile(
        title: Text(complaint.ticketNumber.toString()),
        titleTextStyle: cellTextStyle,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BugDetailPage(
                ticketNumber: complaint.ticketNumber,
                projectName: complaint.projectName,
                bug: complaint.complaint,
                bugNotes: complaint.complaintNotes,
                bugState: complaint.complaintState,
                dateCreated: convertToDateString(complaint.dateCreated),
                author: complaint.author,
                tags: complaint.tags,
              ),
            ),
          );
        },
      ),
      ListTile(
        title: Text(complaint.complaint),
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: Text(complaint.projectName),
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: Text(complaint.author),
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: Text(convertToDateString(complaint.dateCreated)),
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: percentIndicator(percentCompleted),
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Chip(
            label: Text(
              complaint.complaintState.title,
              style: kContainerTextStyle.copyWith(color: Colors.black),
            ),
            backgroundColor: complaint.complaintState.associatedColor,
          ),
        ),
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: assignee != null ? Text(assignee) : null,
        titleTextStyle: cellTextStyle,
      ),
      ListTile(
        title: complaint.tags != null
            ? Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 50.0,
                  child: ListView.builder(
                    itemCount: complaint.tags!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Chip(
                          label: Text(
                            complaint.tags![index].title,
                            style: kContainerTextStyle.copyWith(
                                color: Colors.black),
                          ),
                          backgroundColor:
                              complaint.tags![index].associatedColor,
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
    "AUTHOR",
    "CREATED",
    "PROGRESS",
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
