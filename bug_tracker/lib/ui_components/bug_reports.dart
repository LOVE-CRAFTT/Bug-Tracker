import 'package:bug_tracker/utilities/complaint.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/admin_pages/bug_detail_page.dart';

class BugReports extends StatelessWidget {
  const BugReports({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: complaintsSource.length,
      itemBuilder: (BuildContext context, int index) {
        Complaint bugReport = complaintsSource[index];
        return Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: secondaryThemeColor,
            ),
          ),
          child: ListTile(
            leading: Tooltip(
              message: bugReport.author,
              textStyle: kContainerTextStyle.copyWith(
                fontSize: 13.0,
                color: Colors.black,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text("AS${(index + 1).toString()}"),
              ),
            ),
            title: Text("Bug: ${bugReport.complaint}"),
            titleTextStyle: kContainerTextStyle,
            subtitle: Text("Project:  ${bugReport.associatedProject.name}"),
            subtitleTextStyle: kContainerTextStyle.copyWith(fontSize: 12.0),
            trailing: Text(
              convertToDateString(bugReport.dateCreated),
              style: kContainerTextStyle.copyWith(fontSize: 12.0),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BugDetailPage(
                    ticketNumber: bugReport.ticketNumber,
                    projectName: bugReport.associatedProject.name,
                    bug: bugReport.complaint,
                    bugNotes: bugReport.complaintNotes,
                    bugState: bugReport.complaintState,
                    dateCreated: convertToDateString(bugReport.dateCreated),
                    author: bugReport.author,
                    tags: bugReport.tags,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
