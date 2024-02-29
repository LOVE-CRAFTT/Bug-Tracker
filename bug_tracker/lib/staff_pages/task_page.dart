import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/build_milestones.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/ui_components/complaint.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({
    super.key,
    required this.isTeamLead,
    required this.task,
    required this.complaint,
  });

  final bool isTeamLead;
  final Complaint complaint;
  final String task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var screenIsWide = constraints.maxWidth > 400;
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              /// Introductory details: projectName, complaintID and associated complaint
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Project: ${complaint.projectName}",
                          style: kContainerTextStyle.copyWith(
                            fontSize: 15.0,
                          ),
                        ),
                        //update complaint state
                        HeaderButton(
                          screenIsWide: screenIsWide,
                          buttonText: "Update",
                          onPress: () {},
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Complaint ID: ${complaint.ticketNumber}",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Complaint: ${complaint.complaint}",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 16.0,
                      ),
                    ),
                  ),

                  /// Below is an expanded uneditable text field title "Complaint Notes" showing any additional notes from the user if any
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 20.0,
                    ),
                    child: Text(
                      "Complaint Notes: ",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Container(
                    height: determineContainerDimensionFromConstraint(
                      constraintValue: constraints.maxHeight,
                      subtractValue: 450,
                    ),
                    decoration: BoxDecoration(
                      color: lightAshyNavyBlue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.all(20.0),
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

                  ///Files from user
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 20.0,
                    ),
                    child: Text(
                      "Files: ",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: buildFilesPlaceHolders(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "TASK: $task",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  ///Non - interactive Milestones
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 20.0,
                    ),
                    child: Text(
                      "Milestones: ",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Container(
                    height: determineContainerDimensionFromConstraint(
                      constraintValue: constraints.maxHeight,
                      subtractValue: 300,
                    ),
                    width: determineContainerDimensionFromConstraint(
                      constraintValue: constraints.maxHeight,
                      subtractValue: 300,
                    ),
                    decoration: BoxDecoration(
                      color: lightAshyNavyBlue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: buildMilestones(isUpdate: true),
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

/// Will replace with real files later
ListView buildFilesPlaceHolders() {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 4,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          width: 100,
          height: 100.0,
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    },
  );
}
