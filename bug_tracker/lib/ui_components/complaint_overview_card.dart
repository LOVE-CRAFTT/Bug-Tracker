import 'package:bug_tracker/ui_components/task_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/user_pages/complaint_detail_page.dart';

/// Naming convention in this project dictates a difference between overview and preview cards
/// Overview cards are for when the card contents are the "main focus" of that view/context
/// For example [TaskOverviewCard] is what staff sees however, the admin sees the [TaskPreviewCard] in the bug_detail_page
///
/// Preview cards are the opposite of Overview cards
class ComplaintOverviewCard extends StatelessWidget {
  const ComplaintOverviewCard({
    super.key,
    required this.complaint,
  });

  final Complaint complaint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComplaintDetailPage(
                ticketNumber: complaint.ticketNumber,
                project: complaint.associatedProject.name,
                complaint: complaint.complaint,
                complaintState: complaint.complaintState,
                dateCreated: convertToDateString(complaint.dateCreated),
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: secondaryThemeColor,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "#${complaint.ticketNumber}",
                        style: kContainerTextStyle.copyWith(fontSize: 11),
                      ),
                      Text(
                        "Date Created: ${convertToDateString(complaint.dateCreated)}",
                        style: kContainerTextStyle.copyWith(
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Complaint: ${complaint.complaint}",
                      style: kContainerTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Chip(
                      label: Text(
                        complaint.complaintState.title,
                        style: kContainerTextStyle.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: complaint.complaintState.associatedColor,
                    ),
                  ],
                ),
                Text(
                  "Project: ${complaint.associatedProject.name}",
                  style: kContainerTextStyle.copyWith(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
