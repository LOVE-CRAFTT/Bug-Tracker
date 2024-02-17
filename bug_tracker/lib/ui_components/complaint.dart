import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

/// Widget to describe a complaint in the user page
/// Consists of a column with the ticket number, the complaint title and the associated project
class Complaint extends StatelessWidget {
  const Complaint({
    super.key,
    required this.ticketNumber,
    required this.complaint,
    required this.complaintState,
    required this.projectName,
  });

  final num ticketNumber;
  final String complaint;
  final ComplaintState complaintState;
  final String projectName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      child: InkWell(
        onTap: () {},
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
                Text(
                  "#$ticketNumber",
                  style: kContainerTextStyle.copyWith(fontSize: 11),
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
                        complaintState.title,
                        style: kContainerTextStyle.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: complaintState.associatedColor,
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
