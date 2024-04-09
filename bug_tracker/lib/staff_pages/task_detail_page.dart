import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/task.dart';
import 'package:bug_tracker/utilities/staff.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/utilities/load_tasks_source.dart';
import 'package:bug_tracker/utilities/file_retrieval_functions.dart';
import 'package:bug_tracker/utilities/state_retrieval_functions.dart';
import 'package:bug_tracker/models/component_state_updates.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/ui_components/empty_screen_placeholder.dart';
import 'package:bug_tracker/staff_pages/task_detail_update_page.dart';
import 'package:bug_tracker/ui_components/custom_circular_progress_indicator.dart';

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
  void initState() {
    // This ensures that set task as inProgress is called after
    // initState and build i.e the frame is completed
    // and context has been created
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setTaskStateAsInProgress();
    });
    super.initState();
  }

  void setTaskStateAsInProgress() async {
    TaskState currentTaskState = await getCurrentTaskState(
      taskID: widget.task.id,
    );

    // if task state is not due today, completed, over due,
    // transferred or received
    // and if the state is not already in progress
    // and also if this is the current viewer's task
    // then automatically set as in progress
    if (currentTaskState != TaskState.inProgress &&
        currentTaskState != TaskState.dueToday &&
        currentTaskState != TaskState.completed &&
        currentTaskState != TaskState.overdue &&
        currentTaskState != TaskState.transferred &&
        widget.task.assignedStaff.id == globalActorID) {
      //State's mounted property
      if (mounted) {
        // this then notifies listeners
        context.read<TaskStateUpdates>().updateTaskState(
              taskID: widget.task.id,
              newState: TaskState.inProgress,
            );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Task in Progress!",
              style: kContainerTextStyle.copyWith(color: Colors.black),
            ),
          ),
        );
      }
    }
  }

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
                            onPress: () async {
                              // for populating the dropdown for transfer task process
                              await loadTasksSourceByComplaint(
                                complaintID: widget
                                    .task.associatedComplaint.ticketNumber,
                              );
                              if (context.mounted) {
                                SideSheet.right(
                                  context: context,
                                  width: constraints.maxWidth * 0.9,
                                  sheetColor: lightAshyNavyBlue,
                                  sheetBorderRadius: 10.0,
                                  body: TaskDetailUpdatePage(
                                    maxHeight: constraints.maxHeight,
                                    maxWidth: constraints.maxWidth,
                                    task: widget.task,
                                  ),
                                );
                              }
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

                  /// Below is an expanded uneditable text field title "Complaint Notes"
                  /// showing any additional notes from the user if any
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
                    child: widget.task.associatedComplaint.complaintNotes !=
                            null
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SingleChildScrollView(
                              child: Text(
                                widget.task.associatedComplaint.complaintNotes!,
                                style: kContainerTextStyle.copyWith(
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          )
                        : const EmptyScreenPlaceholder(),
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
                  buildComplaintFiles(
                    complaintID: widget.task.associatedComplaint.ticketNumber,
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
                    child: FutureBuilder(
                      future: loadTasksSourceByComplaint(
                        complaintID:
                            widget.task.associatedComplaint.ticketNumber,
                      ),
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CustomCircularProgressIndicator();
                        } else {
                          // staff data for each task
                          // check for duplicates
                          List<Staff> team = tasksSource
                              .map(
                                (task) => task.assignedStaff,
                              )
                              .toSet()
                              .toList();

                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: team.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                child: Tooltip(
                                  message: getFullNameFromNames(
                                    surname: team[index].surname,
                                    firstName: team[index].firstName,
                                    middleName: team[index].middleName,
                                  ),
                                  textStyle: kContainerTextStyle.copyWith(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 30,
                                    child: Text(
                                      team[index].initials,
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
                      },
                    ),
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
