import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/admin_pages/bug_detail_page.dart';

/// Naming convention in this project dictates a difference between overview and preview cards
/// Overview cards are for when the card contents are the "main focus" of that view/context
/// For example [TaskOverviewCard] is what staff sees however, the admin sees the [TaskPreviewCard] in the bug_detail_page
///
/// Preview cards are the opposite of Overview cards
class BugPreviewCard extends StatelessWidget {
  const BugPreviewCard({
    super.key,
    required this.complaint,
  });
  final Complaint complaint;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: ListTile(
        title: Text(complaint.author),
        titleTextStyle: kContainerTextStyle.copyWith(fontSize: 12.0),
        subtitle: Text("Bug: ${complaint.complaint}"),
        subtitleTextStyle: kContainerTextStyle.copyWith(fontSize: 18.0),
        trailing: Chip(
          label: Text(
            complaint.complaintState.title,
            style: kContainerTextStyle.copyWith(
              color: Colors.black,
            ),
          ),
          backgroundColor: complaint.complaintState.associatedColor,
        ),
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
    );
  }
}
