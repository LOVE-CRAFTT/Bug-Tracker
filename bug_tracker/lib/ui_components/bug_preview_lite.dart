import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/admin_pages/bug_detail_page.dart';

/// "Lite" version of the bug preview card for the admin homepage
class BugPreviewLite extends StatelessWidget {
  const BugPreviewLite({
    super.key,
    required this.complaint,
  });

  final Complaint complaint;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          /// task/bug
          title: Text(complaint.complaint),
          titleTextStyle: kContainerTextStyle.copyWith(
            color: Colors.white,
            fontSize: 20.0,
          ),

          /// project
          subtitle: Text(complaint.associatedProject.name),
          subtitleTextStyle: kContainerTextStyle.copyWith(
            fontSize: 12.0,
          ),

          /// date created
          trailing: Text(
            convertToDateString(complaint.dateCreated),
            style: kContainerTextStyle.copyWith(
              fontSize: 12.0,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BugDetailPage(
                  ticketNumber: complaint.ticketNumber,
                  projectName: complaint.associatedProject.name,
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
        const Divider(
          color: Color(0xFFb6b8aa),
          thickness: 0.2,
        )
      ],
    );
  }
}
