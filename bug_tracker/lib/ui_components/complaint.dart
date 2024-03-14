import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/user_pages/complaint_page.dart';

/// Widget to describe a complaint in the user page
/// Consists of a column with the ticket number, the complaint title and the associated project
class Complaint extends StatelessWidget {
  const Complaint({
    super.key,
    required this.ticketNumber,
    required this.complaint,
    required this.complaintStatus,
    required this.projectName,
    required this.dateCreated,
  });

  final int ticketNumber;
  final String complaint;
  final Status complaintStatus;
  final String projectName;
  final DateTime dateCreated;

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
              builder: (context) => ComplaintPage(
                ticketNumber: ticketNumber,
                project: projectName,
                complaint: complaint,
                complaintStatus: complaintStatus,
                dateCreated: convertToDateString(dateCreated),
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
                        "#$ticketNumber",
                        style: kContainerTextStyle.copyWith(fontSize: 11),
                      ),
                      Text(
                        "Date Created: ${convertToDateString(dateCreated)}",
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
                      "Complaint: $complaint",
                      style: kContainerTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Chip(
                      label: Text(
                        complaintStatus.title,
                        style: kContainerTextStyle.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: complaintStatus.associatedColor,
                    ),
                  ],
                ),
                Text(
                  "Project: $projectName",
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
