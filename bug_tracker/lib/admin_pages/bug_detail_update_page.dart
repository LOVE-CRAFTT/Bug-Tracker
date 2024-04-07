import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/task.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/utilities/staff.dart';
import 'package:bug_tracker/models/component_state_updates.dart';
import 'package:bug_tracker/models/task_update.dart';
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

  // on initState selectedTags should be currentTags
  // on initState teamMember values should be the corresponding values from
  // current tasks, and task controllers should contain the corresponding task strings
  @override
  void initState() {
    selectedTags = widget.currentTags ?? [];
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

    // so the team section is enabled for drawing
    newTeamMemberValues.isEmpty
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
                  if (newTeamLeadTaskTextController.text.isEmpty ||
                      newTeamMembersTaskTextControllers
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
                      task: newTeamLeadTaskTextController.text,

                      // if the text in teamLeadTaskController has changed
                      // from the original then its updated else its new
                      // or if the assigned staff is different
                      // Also if the original is not empty then its updated
                      // The original taskState has to not be completed, overdue or due today
                      // before changing to updated since those are more important
                      taskState: originalTeamLeadTask?.taskState !=
                                  TaskState.completed &&
                              originalTeamLeadTask?.taskState !=
                                  TaskState.overdue &&
                              originalTeamLeadTask?.taskState !=
                                  TaskState.dueToday &&
                              (originalTeamLeadTask != null &&
                                  originalTeamLeadTask!.task.isNotEmpty) &&
                              (newTeamLeadTaskTextController.text !=
                                      originalTeamLeadTask?.task ||
                                  newTeamLeadValue!.id !=
                                      originalTeamLeadTask!.assignedStaff.id)
                          ? TaskState.updated
                          : TaskState.fresh,
                      associatedComplaint: widget.complaint,

                      // always three weeks from now
                      dueDate: DateTime.now()
                          .add(
                            const Duration(days: 21),
                          )
                          .toUtc(),
                      assignedStaff: newTeamLeadValue!,
                      isTeamLead: true,
                    ),
                  );

                  // add team members if any
                  // if this runs values and controllers won't be null because then
                  // newTeamMembersTaskTextControllers will be empty
                  for (var i = 0;
                      i < newTeamMembersTaskTextControllers.length;
                      i++) {
                    taskUpdates.add(
                      Task(
                        // id is unnecessary since will be replaced in db addition
                        // replacing all with placeholder 0
                        id: 0,
                        task: newTeamMembersTaskTextControllers[i].text,

                        // if originalTeamMemberTasks is large enough to prevent value access error
                        // and if newTeamMembersTaskTextControllers list is large enough for the same reasons
                        // the isNotEmpty check is just part of the check for adequate size
                        // and the teamMemberTask.TaskState at current index is not
                        // completed, overdue or due today as those are more important
                        // and finally the teamMember task controller at current index
                        // which contains the updated task is different from the original
                        // contained in teamMemberTasks list at current index, set as updated else set as new
                        taskState: (originalTeamMemberTasks.isNotEmpty &&
                                    originalTeamMemberTasks.length >= i) &&
                                originalTeamMemberTasks
                                        .elementAt(i)
                                        .taskState !=
                                    TaskState.completed &&
                                originalTeamMemberTasks
                                        .elementAt(i)
                                        .taskState !=
                                    TaskState.overdue &&
                                originalTeamMemberTasks
                                        .elementAt(i)
                                        .taskState !=
                                    TaskState.dueToday &&
                                (newTeamMembersTaskTextControllers
                                            .elementAt(i)
                                            .text !=
                                        originalTeamMemberTasks
                                            .elementAt(i)
                                            .task ||
                                    newTeamMemberValues.elementAt(i).id !=
                                        originalTeamMemberTasks
                                            .elementAt(i)
                                            .assignedStaff
                                            .id)
                            ? TaskState.updated
                            : TaskState.fresh,
                        associatedComplaint: widget.complaint,

                        // 3 weeks from now always
                        dueDate: DateTime.now()
                            .add(
                              const Duration(days: 21),
                            )
                            .toUtc(),
                        assignedStaff: newTeamMemberValues[i],
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
                  newTeamLeadTaskTextController.clear();
                  for (var controller in newTeamMembersTaskTextControllers) {
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
