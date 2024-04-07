import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/task.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/utilities/staff.dart';
import 'package:bug_tracker/models/component_state_updates.dart';
import 'package:bug_tracker/models/task_update.dart';
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
  TextEditingController teamLeadTaskController = TextEditingController();
  Staff? teamLeadValue;

  /// List of tasks and drop down values (for team members)
  List<TextEditingController> teamMembersTaskControllers = [];
  List<Staff?> teamMemberValues = [];

  /// selected tags
  List<Tags> selectedTags = [];

  ///
  late bool showTeamSection;

  //
  late Task? teamLeadTask;
  late List<Task> teamMemberTasks;

  // on initState selectedTags should be currentTags
  // on initState teamMember values should be the corresponding values from
  // current tasks, and task controllers should contain the corresponding task strings
  @override
  void initState() {
    teamLeadTask = widget.currentTasks.isEmpty
        ? null
        : widget.currentTasks.firstWhere(
            (task) => task.isTeamLead,
          );
    teamMemberTasks = widget.currentTasks.length > 1
        ? widget.currentTasks
            .where(
              (task) => !task.isTeamLead,
            )
            .toList()
        : [];
    selectedTags = widget.currentTags ?? [];
    // default value for team Lead
    teamLeadValue = teamLeadTask?.assignedStaff ?? staffSource.first;
    teamLeadTaskController.text = teamLeadTask?.task ?? "";
    teamMemberValues = teamMemberTasks
        .map(
          (task) => task.assignedStaff,
        )
        .toList();
    teamMembersTaskControllers = teamMemberTasks
        .map(
          (task) => TextEditingController(text: task.task),
        )
        .toList();

    // so the team section is enabled for drawing
    teamMemberValues.isEmpty ? showTeamSection = false : showTeamSection = true;
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
              dropDownValue: teamLeadValue,
              taskController: teamLeadTaskController,
              onChange: (value) {
                setState(() {
                  teamLeadValue = value;
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
            for (int i = 0; i < teamMembersTaskControllers.length; i++)
              TaskAssignmentForm(
                  dropDownValue: teamMemberValues[i],
                  taskController: teamMembersTaskControllers[i],
                  onChange: (value) {
                    setState(() {
                      teamMemberValues[i] = value;
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
                          teamMembersTaskControllers.add(
                            TextEditingController(),
                          );
                          teamMemberValues.add(
                            staffSource.first,
                          );
                        },
                      );
                    },
                    child: const Text('Add Team Member'),
                  ),
                ),

                // only show if there is a team member to be removed
                if (teamMemberValues.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        textStyle: kContainerTextStyle,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            teamMembersTaskControllers.removeLast();
                            teamMemberValues.removeLast();
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
                  if (teamLeadTaskController.text.isEmpty ||
                      teamMembersTaskControllers
                          .any((controller) => controller.text.isEmpty)) {
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

                  // add team lead
                  taskUpdates.add(
                    Task(
                      // id is to be replaces so placeholder
                      id: 0,
                      task: teamLeadTaskController.text,

                      // if the text in teamLeadTaskController has changed
                      // from the original then its updated else its new
                      // Also if the original is not empty then its updated
                      // The taskState has to not be completed, overdue or due today
                      // before changing to updated since those are more important
                      taskState: teamLeadTask?.taskState !=
                                  TaskState.completed &&
                              teamLeadTask?.taskState != TaskState.overdue &&
                              teamLeadTask?.taskState != TaskState.dueToday &&
                              (teamLeadTask != null &&
                                  teamLeadTask!.task.isNotEmpty) &&
                              teamLeadTaskController.text != teamLeadTask?.task
                          ? TaskState.updated
                          : TaskState.fresh,
                      associatedComplaint: widget.complaint,

                      // always three weeks from now
                      dueDate: DateTime.now()
                          .add(
                            const Duration(days: 21),
                          )
                          .toUtc(),
                      assignedStaff: teamLeadValue!,
                      isTeamLead: true,
                    ),
                  );

                  // add team members if any
                  // if this runs values and controllers won't be null because then
                  // teamMemberValues will be empty
                  for (var i = 0; i < teamMembersTaskControllers.length; i++) {
                    taskUpdates.add(
                      Task(
                        // id is unnecessary since will be replaced in db addition
                        // replacing all with placeholder 0
                        id: 0,
                        task: teamMembersTaskControllers[i].text,

                        // if teamMemberTasks is large enough to prevent value access error
                        // and if teamMembersTaskControllers list is large enough for the same reasons
                        // the isNotEmpty check is just part of the check for adequate size
                        // and the teamMemberTask.TaskState at current index is not
                        // completed, overdue or due today as those are more important
                        // and finally the teamMember task controller at current index
                        // which contains the updated task is different from the original
                        // contained in teamMemberTasks list at current index, set as updated else set as new
                        taskState: (teamMemberTasks.isNotEmpty &&
                                    teamMemberTasks.length >= i &&
                                    teamMembersTaskControllers.length >= i) &&
                                teamMemberTasks.elementAt(i).taskState !=
                                    TaskState.completed &&
                                teamMemberTasks.elementAt(i).taskState !=
                                    TaskState.overdue &&
                                teamMemberTasks.elementAt(i).taskState !=
                                    TaskState.dueToday &&
                                (teamMembersTaskControllers.elementAt(i).text !=
                                    teamMemberTasks.elementAt(i).task)
                            ? TaskState.updated
                            : TaskState.fresh,
                        associatedComplaint: widget.complaint,

                        // 3 weeks from now always
                        dueDate: DateTime.now()
                            .add(
                              const Duration(days: 21),
                            )
                            .toUtc(),
                        assignedStaff: teamMemberValues[i]!,
                        isTeamLead: false,
                      ),
                    );
                  }

                  // update the tags using the function that notifies
                  // Bug detail page
                  context.read<ComponentStateUpdates>().updateComplaintTags(
                        complaintID: widget.complaint.ticketNumber,
                        newTags: selectedTags,
                      );

                  //also update tasks that notifies Bug Detail Page
                  context
                      .read<TaskUpdate>()
                      .updateTasks(taskUpdates: taskUpdates);

                  Navigator.pop(context);
                  teamLeadTaskController.clear();
                  for (var controller in teamMembersTaskControllers) {
                    controller.clear();
                  }
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
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
