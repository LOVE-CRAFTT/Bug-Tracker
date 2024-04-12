import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/project.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/load_complaints_source.dart';
import 'package:bug_tracker/admin_pages/project_detail_page.dart';
import 'package:bug_tracker/ui_components/custom_linear_percent_indicator.dart';
import 'package:bug_tracker/ui_components/custom_circular_progress_indicator.dart';

TableRow buildTableRow({
  required BuildContext context,
  required Project project,
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
              builder: (context) => ProjectDetailPage(
                project: project,
              ),
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
        title: FutureBuilder(
          future: getPercentageOfProjectCompleted(project: project),
          builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CustomCircularProgressIndicator());
            } else {
              return percentIndicator(normalize0to1(snapshot.data!));
            }
          },
        ),
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

Future<double> getPercentageOfProjectCompleted(
    {required Project project}) async {
  List<Complaint> relatedComplaints =
      await retrieveComplaintsByProject(projectID: project.id);
  if (relatedComplaints.isEmpty) return 0.0;

  int complaintsCompletedLength = relatedComplaints
      .where(
        (complaint) => complaint.complaintState == ComplaintState.completed,
      )
      .length;

  // finally
  return getPercentage(
    number: complaintsCompletedLength,
    total: relatedComplaints.length,
  );
}
