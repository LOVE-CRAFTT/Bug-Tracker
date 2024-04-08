import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/utilities/task.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/load_tasks_source.dart';
import 'package:bug_tracker/ui_components/custom_linear_percent_indicator.dart';
import 'package:bug_tracker/admin_pages/bug_detail_page.dart';
import 'package:bug_tracker/ui_components/custom_circular_progress_indicator.dart';

TableRow buildTableRow({
  required BuildContext context,
  required Complaint complaint,
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
                complaint: complaint,
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
        title: Text(complaint.associatedProject.name),
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
        title: FutureBuilder(
          future: getPercentageOfComplaintCompleted(complaint: complaint),
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
    "TAGS",
  ];

  return headerNames
      .map((header) => ListTile(
            title: Text(header),
            titleTextStyle: cellTextStyle,
          ))
      .toList();
}

Future<double> getPercentageOfComplaintCompleted(
    {required Complaint complaint}) async {
  List<Task> relatedTasks =
      await retrieveTasksByComplaint(complaintID: complaint.ticketNumber);
  if (relatedTasks.isEmpty) return 0.0;

  int tasksCompletedLength = relatedTasks
      .where(
        (task) => task.taskState == TaskState.completed,
      )
      .length;

  // finally
  return getPercentage(
    number: tasksCompletedLength,
    total: relatedTasks.length,
  );
}
