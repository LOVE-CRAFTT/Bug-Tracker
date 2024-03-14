import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/build_complaint_notes.dart';

class ComplaintPage extends StatelessWidget {
  const ComplaintPage({
    super.key,
    required this.ticketNumber,
    required this.project,
    required this.complaint,
    required this.complaintState,
    required this.dateCreated,
  });

  final int ticketNumber;
  final String project;
  final String complaint;
  final String dateCreated;
  final ComplaintState complaintState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Complaint ID: $ticketNumber",
                          style: kContainerTextStyle.copyWith(
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          "Date Created: $dateCreated",
                          style: kContainerTextStyle.copyWith(
                            fontSize: 14.0,
                          ),
                        ),
                      ],
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
                        fontSize: 16.0,
                      ),
                    ),
                  ),

                  /// Below is an expanded uneditable text field title "Complaint Notes" showing any additional notes from the user if any
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 20.0,
                    ),
                    child: Text(
                      "Complaint Notes",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      height: constraints.maxHeight - 450 > 0
                          ? constraints.maxHeight - 450
                          : 0,
                      decoration: BoxDecoration(
                        color: lightAshyNavyBlue,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          child: Text(
                            complaintNotesPlaceholder,
                            style: kContainerTextStyle.copyWith(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// All states of the complaints are available as chips and they are each grayed out or colored
                  /// based on the state of the complaint
                  /// Enums are compared with names because the hashCodes change as new objects are created
                  /// Since hashCodes are used in the equality comparison, the changing hashCodes can break it
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Chip(
                          label: Text(
                            "Pending",
                            style: kContainerTextStyle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          backgroundColor:
                              complaintState.name == ComplaintState.pending.name
                                  ? complaintState.associatedColor
                                  : Colors.grey.withAlpha(25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Chip(
                          label: Text(
                            "Acknowledged",
                            style: kContainerTextStyle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          backgroundColor: complaintState.name ==
                                  ComplaintState.acknowledged.name
                              ? complaintState.associatedColor
                              : Colors.grey.withAlpha(25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Chip(
                          label: Text(
                            "In Progress",
                            style: kContainerTextStyle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          backgroundColor: complaintState.name ==
                                  ComplaintState.inProgress.name
                              ? complaintState.associatedColor
                              : Colors.grey.withAlpha(25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Chip(
                          label: Text(
                            "Completed",
                            style: kContainerTextStyle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          backgroundColor: complaintState.name ==
                                  ComplaintState.completed.name
                              ? complaintState.associatedColor
                              : Colors.grey.withAlpha(25),
                        ),
                      ),
                    ],
                  ),

                  /// Below is an expanded uneditable text field title "Staff Notes and Work Plan" showing the notes from the staff
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 20.0,
                    ),
                    child: Text(
                      "Staff Notes",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight - 200 > 0
                        ? constraints.maxHeight - 200
                        : 0,
                    decoration: BoxDecoration(
                      color: lightAshyNavyBlue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: buildNotes(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
