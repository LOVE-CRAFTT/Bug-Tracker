import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

class ComplaintPage extends StatelessWidget {
  const ComplaintPage({
    super.key,
    required this.ticketNumber,
    required this.project,
    required this.complaint,
  });
  final int ticketNumber;
  final String project;
  final String complaint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Complaint ID: $ticketNumber",
                    style: kContainerTextStyle.copyWith(
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Project: $project",
                    style: kContainerTextStyle.copyWith(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Bug: $complaint",
                    style: kContainerTextStyle.copyWith(
                      fontSize: 18.0,
                    ),
                  ),
                ),

                /// All states of the complaints are to be available as chips and they are each grayed out or colored
                /// based on the state of the complaint
                /// Below is an expanded uneditable text field title "Staff Notes and Work Plan" showing the notes from the staff
              ],
            ),
          ),
        ),
      ),
    );
  }
}
