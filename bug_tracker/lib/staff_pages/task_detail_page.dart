import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/utilities/task.dart';
import 'package:bug_tracker/staff_pages/tasks_update_page.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({
    super.key,
    required this.task,
    required this.viewingFromBug,
  });

  final Task task;
  final bool viewingFromBug;

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericTaskBar("Task Detail"),
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
                          "Project: ${widget.task.associatedComplaint.associatedProject.name}",
                          style: kContainerTextStyle.copyWith(
                            fontSize: 15.0,
                          ),
                        ),

                        //update complaint state
                        if (widget.viewingFromBug == false)
                          HeaderButton(
                            screenIsWide: screenIsWide,
                            buttonText: "Update",
                            onPress: () {
                              SideSheet.right(
                                context: context,
                                width: constraints.maxWidth * 0.9,
                                sheetColor: lightAshyNavyBlue,
                                sheetBorderRadius: 10.0,
                                body: TasksUpdatePage(
                                  maxHeight: constraints.maxHeight,
                                  maxWidth: constraints.maxWidth,
                                  isTeamLead: widget.task.isTeamLead,
                                ),
                              );
                            },
                          )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Task ID: ${widget.task.id}",
                          style: kContainerTextStyle.copyWith(
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          "Complaint ID: ${widget.task.associatedComplaint.ticketNumber}",
                          style: kContainerTextStyle.copyWith(
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Complaint: ${widget.task.associatedComplaint.complaint}",
                          style: kContainerTextStyle.copyWith(
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          "Due date: ${convertToDateString(widget.task.dueDate)}",
                          style: kContainerTextStyle.copyWith(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),

                    /// Actual task
                    child: Text(
                      "TASK: ${widget.task.task}",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  ///Team member(s)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 20.0,
                    ),
                    child: Text(
                      "Team: ",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: buildTeamMembers(),
                  )
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

/// Will also replace with real team members
ListView buildTeamMembers() {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 3,
    itemBuilder: (BuildContext context, int index) {
      List teamMembers = [
        "Alan Broker",
        "Windsor Elizabeth",
        "Winston Churchill",
      ];
      List teamMembersInitials = ["AB", "WE", "WC"];
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: Tooltip(
          message: teamMembers[index],
          textStyle: kContainerTextStyle.copyWith(
            color: Colors.black,
            fontSize: 14,
          ),
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 30,
            child: Text(
              teamMembersInitials[index],
              style: kContainerTextStyle.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ),
      );
    },
  );
}
