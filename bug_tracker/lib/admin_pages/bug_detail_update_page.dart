import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/task.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/utilities/staff.dart';
import 'package:bug_tracker/models/component_state_updates.dart';
import 'package:bug_tracker/models/tasks_update.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/ui_components/task_assignment_form.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:provider/provider.dart';

class BugDetailUpdatePage extends StatefulWidget {
  const BugDetailUpdatePage({
    super.key,
    required this.constraints,
    required this.complaint,
    required this.currentTags,
    required this.currentTasks,
  });

  final BoxConstraints constraints;
  final Complaint complaint;
  final List<Tags>? currentTags;
  final List<Task> currentTasks;

  @override
  State<BugDetailUpdatePage> createState() => _BugDetailUpdatePageState();
}

class _BugDetailUpdatePageState extends State<BugDetailUpdatePage> {
  /// Task and drop down value for team lead
  TextEditingController newTeamLeadTaskTextController = TextEditingController();
  Staff? newTeamLeadValue;

  /// List of tasks and drop down values (for team members)
  List<TextEditingController> newTeamMembersTaskTextControllers = [];
  List<Staff> newTeamMemberValues = [];

  /// selected tags
  List<Tags> selectedTags = [];

  ///
  late bool showTeamSection;

  //
  late Task? originalTeamLeadTask;
  late List<Task> originalTeamMemberTasks;

  // remaining after deleting/addition of new tasks
  // for updating the work sessions referenced ids
  List<int> activeTaskIDs = [];

  // on initState selectedTags should be currentTags
  // on initState teamMember values should be the corresponding values from
  // current tasks, and task controllers should contain the corresponding task strings
  @override
  void initState() {
    selectedTags = widget.currentTags ?? [];

    // divide the tasks into team lead and team member tasks
    originalTeamLeadTask = widget.currentTasks.isEmpty
        ? null
        : widget.currentTasks.firstWhere(
            (task) => task.isTeamLead,
          );
    originalTeamMemberTasks = widget.currentTasks.length > 1
        ? widget.currentTasks
            .where(
              (task) => !task.isTeamLead,
            )
            .toList()
        : [];

    // default value for team Lead
    newTeamLeadValue = originalTeamLeadTask?.assignedStaff ?? staffSource.first;
    newTeamLeadTaskTextController.text = originalTeamLeadTask?.task ?? "";
    newTeamMemberValues = originalTeamMemberTasks
        .map(
          (task) => task.assignedStaff,
        )
        .toList();
    newTeamMembersTaskTextControllers = originalTeamMemberTasks
        .map(
          (task) => TextEditingController(text: task.task),
        )
        .toList();

    // populate active taskIDs
    if (originalTeamLeadTask != null) {
      activeTaskIDs.add(originalTeamLeadTask!.id);
    }
    activeTaskIDs.addAll(originalTeamMemberTasks.map((task) => task.id));

    // so the team section is enabled for drawing
    widget.currentTasks.isEmpty
        ? showTeamSection = false
        : showTeamSection = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Selecting tags
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Tags: ",
                  style: kContainerTextStyle,
                ),
              ),
              SizedBox(
                height: 70.0,
                width: widget.constraints.maxWidth - 300,

                // This is a list of all Tags enum as filter chips that are
                // either selected or not based on the selected Tags list.
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Tags.values.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FilterChip(
                        label: Text(
                          Tags.values[index].title,
                          style: kContainerTextStyle.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        selected: selectedTags.contains(Tags.values[index]),
                        onSelected: (bool value) {
                          setState(() {
                            // if selecting to add
                            if (value == true) {
                              selectedTags.add(Tags.values[index]);
                            }
                            // else selecting to remove
                            else {
                              selectedTags.remove(Tags.values[index]);
                            }
                          });
                        },
                        selectedColor: Tags.values[index].associatedColor,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // Checkbox to show/hide team section
          CheckboxListTile(
            title: Text(
              "Show team section",
              style: kContainerTextStyle.copyWith(
                fontSize: 20.0,
              ),
            ),
            value: showTeamSection,
            onChanged: (value) {
              setState(() {
                showTeamSection = value!;
              });
            },
            // once enabled can't be disabled
            enabled: !showTeamSection,
          ),

          // Team section
          if (showTeamSection) ...[
            /// Team lead
            const Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                top: 20.0,
                right: 20.0,
              ),
              child: Text(
                "Team Lead",
                style: kContainerTextStyle,
              ),
            ),
            TaskAssignmentForm(
              // if no team lead ensure placeholder for team lead so that done button
              // is not clicked accidentally and an erroneous value is added to the database
              // essentially so actual staff(team lead) is added
              dropDownValue: newTeamLeadValue,
              taskController: newTeamLeadTaskTextController,
              onChange: (value) {
                setState(() {
                  newTeamLeadValue = value;
                });
              },
            ),

            /// Team members
            const Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                top: 20.0,
                right: 20.0,
              ),
              child: Text(
                "Team Members",
                style: kContainerTextStyle,
              ),
            ),
            for (int i = 0; i < newTeamMembersTaskTextControllers.length; i++)
              TaskAssignmentForm(
                  dropDownValue: newTeamMemberValues[i],
                  taskController: newTeamMembersTaskTextControllers[i],
                  onChange: (value) {
                    setState(() {
                      // value will always exist since
                      // when adding new task assignment form we add staffSource.first
                      // and when drawing, it only draws if values for staff is available
                      // i.e for statement length check
                      newTeamMemberValues[i] = value!;
                    });
                  }),

            // Buttons to add a new team member
            // and remove team Member
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: kContainerTextStyle,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          newTeamMembersTaskTextControllers.add(
                            TextEditingController(),
                          );
                          newTeamMemberValues.add(
                            staffSource.first,
                          );

                          activeTaskIDs.add(0);
                        },
                      );
                    },
                    child: const Text('Add Team Member'),
                  ),
                ),

                // only show if there is a team member to be removed
                if (newTeamMemberValues.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        textStyle: kContainerTextStyle,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            newTeamMembersTaskTextControllers.removeLast();
                            newTeamMemberValues.removeLast();

                            if (activeTaskIDs.isNotEmpty) {
                              activeTaskIDs.removeLast();
                            }
                          },
                        );
                      },
                      child: const Text('Remove Last'),
                    ),
                  ),
              ],
            ),
          ],

          /// done
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: HeaderButton(
                screenIsWide: true,
                buttonText: "Done",
                onPress: () async {
                  // create List of Task Object from selected value i.e staff
                  // and task controllers
                  List<Task> taskUpdates = [];

                  //if there isn't text(task) in any field then notify that the task is necessary
                  if (newTeamLeadTaskTextController.text.trim().isEmpty ||
                      newTeamMembersTaskTextControllers.any(
                          (controller) => controller.text.trim().isEmpty)) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(
                            "All tasks must be added!",
                            style: kContainerTextStyle.copyWith(
                              color: Colors.redAccent,
                            ),
                          ),
                        );
                      },
                    );
                    return;
                  }

                  bool hasNewTasks = false;
                  bool hasUpdatedTasks = false;
                  int taskId;

                  // add team lead
                  {
                    TaskState taskState;

                    // if there is an original team lead task and
                    // if the newly assigned staff is different from the original
                    // and if the task is not one that has been transferred
                    // then it is marked as new
                    if ((originalTeamLeadTask != null) &&
                        (newTeamLeadValue!.id !=
                            originalTeamLeadTask!.assignedStaff.id) &&
                        (originalTeamLeadTask!.taskState !=
                            TaskState.transferred)) {
                      taskState = TaskState.fresh;
                      hasNewTasks = true;

                      taskId = originalTeamLeadTask!.id;
                    }
                    // if there is an original team lead task and
                    // if the text in newTeamLeadTaskTextController has changed
                    // from the original
                    // and if the task is not one that has been transferred
                    // then it is marked as updated

                    else if ((originalTeamLeadTask != null) &&
                        (newTeamLeadTaskTextController.text !=
                            originalTeamLeadTask!.task) &&
                        (originalTeamLeadTask!.taskState !=
                            TaskState.transferred)) {
                      taskState = TaskState.updated;
                      hasUpdatedTasks = true;

                      taskId = originalTeamLeadTask!.id;
                    }

                    // else if there is an original team lead task but
                    // none of the task and assigned staff is changed
                    // the state is whatever it was before
                    else if ((originalTeamLeadTask != null) &&
                        (newTeamLeadTaskTextController.text ==
                                originalTeamLeadTask!.task &&
                            newTeamLeadValue!.id ==
                                originalTeamLeadTask!.assignedStaff.id)) {
                      taskState = originalTeamLeadTask!.taskState;

                      taskId = originalTeamLeadTask!.id;
                    }

                    // at this point there no original task meaning it is new
                    else {
                      taskState = TaskState.fresh;
                      hasNewTasks = true;

                      taskId = 0;
                    }

                    taskUpdates.add(
                      Task(
                        id: taskId,
                        task: newTeamLeadTaskTextController.text,

                        taskState: taskState,
                        associatedComplaint: widget.complaint,

                        // always 4 weeks from now i.e 1 month
                        dueDate: DateTime.now().add(
                          const Duration(days: 28),
                        ),
                        assignedStaff: newTeamLeadValue!,
                        isTeamLead: true,
                      ),
                    );
                  }

                  // add team members if any
                  {
                    TaskState taskState;

                    for (var i = 0;
                        i < newTeamMembersTaskTextControllers.length;
                        i++) {
                      // if originalTeamMemberTasks is large enough to prevent value access error
                      // and if the staff has changed
                      // and if the task is not one that has been transferred
                      // then it is new
                      if ((originalTeamMemberTasks.length > i) &&
                          (newTeamMemberValues.elementAt(i).id !=
                              originalTeamMemberTasks
                                  .elementAt(i)
                                  .assignedStaff
                                  .id) &&
                          (originalTeamMemberTasks.elementAt(i).taskState !=
                              TaskState.transferred)) {
                        taskState = TaskState.fresh;
                        hasNewTasks = true;

                        taskId = originalTeamMemberTasks.elementAt(i).id;
                      }

                      // if originalTeamMemberTasks is large enough to prevent value access error
                      // and if the text corresponding task has changed
                      // and if the task is not one that has been transferred
                      // then it is updated
                      else if ((originalTeamMemberTasks.length > i) &&
                          (newTeamMembersTaskTextControllers
                                  .elementAt(i)
                                  .text !=
                              originalTeamMemberTasks.elementAt(i).task) &&
                          (originalTeamMemberTasks.elementAt(i).taskState !=
                              TaskState.transferred)) {
                        taskState = TaskState.updated;
                        hasUpdatedTasks = true;

                        taskId = originalTeamMemberTasks.elementAt(i).id;
                      }

                      // if originalTeamMemberTasks is large enough to prevent value access error
                      // and if the staff and text of the corresponding task have not changed
                      // then the state is left as is
                      else if ((originalTeamMemberTasks.length > i) &&
                          (newTeamMembersTaskTextControllers
                                      .elementAt(i)
                                      .text ==
                                  originalTeamMemberTasks.elementAt(i).task &&
                              newTeamMemberValues.elementAt(i).id ==
                                  originalTeamMemberTasks
                                      .elementAt(i)
                                      .assignedStaff
                                      .id)) {
                        taskState =
                            originalTeamMemberTasks.elementAt(i).taskState;

                        taskId = originalTeamMemberTasks.elementAt(i).id;
                      }

                      // at this point the originalTeamMemberTasks does not contain a value
                      // at this position, meaning it is a new task
                      else {
                        taskState = TaskState.fresh;
                        hasNewTasks = true;

                        taskId = 0;
                      }

                      taskUpdates.add(
                        Task(
                          id: taskId,
                          task: newTeamMembersTaskTextControllers[i].text,

                          taskState: taskState,
                          associatedComplaint: widget.complaint,

                          // 4 weeks from now always i.e 1 month
                          dueDate: DateTime.now().add(
                            const Duration(days: 28),
                          ),
                          assignedStaff: newTeamMemberValues[i],
                          isTeamLead: false,
                        ),
                      );
                    }
                  }

                  // update the tags using the function that notifies
                  // Bug detail page
                  await context
                      .read<ComplaintStateUpdates>()
                      .updateComplaintTags(
                        complaintID: widget.complaint.ticketNumber,
                        newTags: selectedTags,
                      );

                  // update tasks which notifies Bug Detail Page
                  if (context.mounted) {
                    await context.read<TasksUpdate>().wipeAndUpdateTasks(
                          taskUpdates: taskUpdates,

                          // remove the 0s
                          preservedOriginalTaskIDs: activeTaskIDs
                              .where(
                                (ids) => ids != 0,
                              )
                              .toList(),
                        );
                  }

                  // make complaint in progress
                  // if there are new or updated tasks
                  if (hasNewTasks || hasUpdatedTasks) {
                    if (context.mounted) {
                      await context
                          .read<ComplaintStateUpdates>()
                          .updateComplaintState(
                            complaintID: widget.complaint.ticketNumber,
                            newState: ComplaintState.inProgress,
                          );
                    }

                    // notify
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Complaint in progress!",
                            style: kContainerTextStyle.copyWith(
                                color: Colors.black),
                          ),
                        ),
                      );
                    }
                  }

                  if (context.mounted) {
                    Navigator.pop(context);
                    newTeamLeadTaskTextController.clear();
                    for (var controller in newTeamMembersTaskTextControllers) {
                      controller.clear();
                    }
                    activeTaskIDs.clear();
                    showTeamSection = false;
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
          ),
        ],
      ),
    );
  }
}
