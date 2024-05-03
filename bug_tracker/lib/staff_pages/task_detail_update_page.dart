import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/staff.dart';
import 'package:bug_tracker/utilities/task.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/models/tasks_update.dart';
import 'package:bug_tracker/models/component_state_updates.dart';
import 'package:bug_tracker/models/staff_notes_updates.dart';

/// Separated this way so set-state can be accessed
class TaskDetailUpdatePage extends StatefulWidget {
  const TaskDetailUpdatePage({
    super.key,
    required this.maxHeight,
    required this.maxWidth,
    required this.task,
  });

  final double maxHeight;
  final double maxWidth;
  final Task task;

  @override
  State<TaskDetailUpdatePage> createState() => _TaskDetailUpdatePageState();
}

class _TaskDetailUpdatePageState extends State<TaskDetailUpdatePage> {
  bool taskCompleted = false;
  bool complaintCompleted = false;
  late Staff dropDownValue;

  ///Text editing Controllers
  TextEditingController userNoteController = TextEditingController();

  // if viewing this page then actor is coming from task detail page
  // meaning tasksSource has been loaded with tasks related to this complaint
  // from getting team process
  // Remove duplicates resulting from a task transfer
  // or multiple tasks
  List<Staff> teamMembers = tasksSource
      .map(
        (task) => task.assignedStaff,
      )
      .toSet()
      .toList();

  @override
  void initState() {
    // initial value should be the current staff
    dropDownValue = teamMembers.firstWhere(
      (staff) => staff.id == globalActorID,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Option to mark task as completed if it is not transferred
          if (widget.task.taskState != TaskState.transferred) ...[
            SizedBox(
              width: determineContainerDimensionFromConstraint(
                constraintValue: widget.maxHeight,
                subtractValue: 300,
              ),
              child: CheckboxListTile(
                value: taskCompleted,
                onChanged: (value) {
                  taskCompleted = value!;
                  setState(() {});
                },
                title: Text(
                  "Mark task as Completed",
                  style: checkboxTextStyle,
                ),
              ),
            )
          ],

          /// Transfer tasks dropdown
          makeTitle(title: "Transfer task"),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 40.0,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: secondaryThemeColorBlue),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: DropdownButton(
                  value: dropDownValue,
                  items: teamMembers
                      .map(
                        (staff) => DropdownMenuItem(
                          value: staff,
                          child: Text(
                            getFullNameFromNames(
                              surname: staff.surname,
                              firstName: staff.firstName,
                              middleName: staff.middleName,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (selected) {
                    setState(() {
                      dropDownValue = selected!;
                    });
                  },
                  underline: Container(
                    decoration: const BoxDecoration(border: Border()),
                  ),
                  style: kContainerTextStyle.copyWith(
                    color: Colors.grey,
                  ),
                  padding: const EdgeInsets.all(10.0),
                ),
              ),
            ),
          ),

          /// Mark Complaint as completed if isTeamLead

          if (widget.task.isTeamLead) ...[
            /// Title
            SizedBox(
              width: determineContainerDimensionFromConstraint(
                constraintValue: widget.maxHeight,
                subtractValue: 300,
              ),
              child: CheckboxListTile(
                value: complaintCompleted,
                onChanged: (value) {
                  complaintCompleted = value!;
                  setState(() {});
                },
                title: Text(
                  "Mark Complaint as Completed",
                  style: checkboxTextStyle.copyWith(fontSize: 30.0),
                ),
              ),
            ),

            ///Notes to user if isTeamLead
            makeTitle(title: "Notes to User: "),

            SizedBox(
              height: determineContainerDimensionFromConstraint(
                constraintValue: widget.maxHeight,
                subtractValue: 300,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 15.0,
                ),
                child: TextField(
                  style: kContainerTextStyle.copyWith(
                    color: Colors.black,
                  ),
                  controller: userNoteController,
                  decoration: InputDecoration(
                    hintText: "Notes",
                    hintStyle:
                        kContainerTextStyle.copyWith(color: Colors.black45),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                  expands: true,
                  maxLines: null,
                ),
              ),
            ),
          ],

          /// Once done is clicked navigator.pop and then redraw
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: HeaderButton(
                screenIsWide: true,
                buttonText: "Done",
                onPress: () async {
                  // update task state to completed
                  if (taskCompleted) {
                    await context.read<TaskStateUpdates>().updateTaskState(
                          taskID: widget.task.id,
                          newState: TaskState.completed,
                        );
                  }

                  // if staff wants to transfer task
                  // known if the transfer task dropDownValue has been changed
                  // to a different staff
                  if (dropDownValue != widget.task.assignedStaff) {
                    // add new task with newly assigned staff
                    if (context.mounted) {
                      await context.read<TasksUpdate>().addNewTransferredTask(
                            task: Task(
                              // will change so just a placeholder value
                              id: 0,

                              // set task string
                              task: widget.task.task,

                              // new task state will received
                              taskState: TaskState.received,

                              // same complaint
                              associatedComplaint:
                                  widget.task.associatedComplaint,

                              // same due date to account for deadlines
                              dueDate: widget.task.dueDate,

                              // newly assigned staff
                              assignedStaff: dropDownValue,

                              // always just one team lead
                              isTeamLead: false,
                            ),
                          );
                    }

                    // set state as transferred
                    if (context.mounted) {
                      await context.read<TaskStateUpdates>().updateTaskState(
                            taskID: widget.task.id,

                            // transferred
                            newState: TaskState.transferred,
                          );
                    }
                  }

                  // update task to completed if is team lead and there's intent
                  if (widget.task.isTeamLead && complaintCompleted) {
                    if (context.mounted) {
                      await context
                          .read<ComplaintStateUpdates>()
                          .updateComplaintState(
                            complaintID:
                                widget.task.associatedComplaint.ticketNumber,
                            newState: ComplaintState.completed,
                          );
                    }
                  }

                  // add staff note if is team lead and there's intent
                  if (widget.task.isTeamLead &&
                      userNoteController.text.trim().isNotEmpty) {
                    if (context.mounted) {
                      await context
                          .read<StaffNotesUpdates>()
                          .addStaffNoteToComplaint(
                            complaintID:
                                widget.task.associatedComplaint.ticketNumber,
                            note: userNoteController.text,
                          );
                    }
                  }

                  if (context.mounted) {
                    Navigator.pop(context);
                    userNoteController.clear();

                    // notify
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Updated successfully",
                          style:
                              kContainerTextStyle.copyWith(color: Colors.black),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

Padding makeTitle({required String title}) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 20.0,
      right: 20.0,
      top: 20.0,
    ),
    child: Text(
      title,
      style: kContainerTextStyle.copyWith(
        fontSize: 16.0,
      ),
    ),
  );
}
