import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/utilities/build_staff_notes.dart';
import 'package:bug_tracker/utilities/file_retrieval_functions.dart';
import 'package:bug_tracker/models/component_state_updates.dart';
import 'package:bug_tracker/models/staff_notes_updates.dart';
import 'package:bug_tracker/ui_components/empty_screen_placeholder.dart';

class ComplaintDetailPage extends StatelessWidget {
  const ComplaintDetailPage({
    super.key,
    required this.complaint,
  });

  final Complaint complaint;

  @override
  Widget build(BuildContext context) {
    // watch ComplaintStateUpdates for updates to complaint
    // and rebuild
    context.watch<ComplaintStateUpdates>();

    // watch StaffNotesUpdates for updates to staff notes and rebuild
    context.watch<StaffNotesUpdates>();
    return Scaffold(
      appBar: genericTaskBar("Complaint Detail"),
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
                          "Complaint ID: ${complaint.ticketNumber}",
                          style: kContainerTextStyle.copyWith(
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          "Date Created: ${convertToDateString(complaint.dateCreated)}",
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
                      "Project: ${complaint.associatedProject.name}",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Complaint: ${complaint.complaint}",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 20.0,
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
                      child: complaint.complaintNotes != null
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SingleChildScrollView(
                                child: Text(
                                  complaint.complaintNotes!,
                                  style: kContainerTextStyle.copyWith(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            )
                          : const EmptyScreenPlaceholder(),
                    ),
                  ),

                  ///Files from user
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 20.0,
                    ),
                    child: Text(
                      "Files: ",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  buildComplaintFiles(complaintID: complaint.ticketNumber),

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
                          backgroundColor: complaint.complaintState.name ==
                                  ComplaintState.pending.name
                              ? complaint.complaintState.associatedColor
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
                          backgroundColor: complaint.complaintState.name ==
                                  ComplaintState.acknowledged.name
                              ? complaint.complaintState.associatedColor
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
                          backgroundColor: complaint.complaintState.name ==
                                  ComplaintState.inProgress.name
                              ? complaint.complaintState.associatedColor
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
                          backgroundColor: complaint.complaintState.name ==
                                  ComplaintState.completed.name
                              ? complaint.complaintState.associatedColor
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
                      child:
                          buildStaffNotes(complaintID: complaint.ticketNumber),
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
