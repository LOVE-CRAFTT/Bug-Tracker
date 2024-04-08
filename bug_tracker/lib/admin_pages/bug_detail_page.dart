import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:bug_tracker/models/tasks_update.dart';
import 'package:bug_tracker/models/component_state_updates.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/task.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/utilities/build_staff_notes.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/utilities/load_complaints_source.dart';
import 'package:bug_tracker/utilities/load_tasks_source.dart';
import 'package:bug_tracker/utilities/load_staff_source.dart';
import 'package:bug_tracker/utilities/file_retrieval_functions.dart';
import 'package:bug_tracker/utilities/state_retrieval_functions.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/ui_components/task_preview_card.dart';
import 'package:bug_tracker/ui_components/custom_circular_progress_indicator.dart';
import 'package:bug_tracker/admin_pages/bug_detail_update_page.dart';

class BugDetailPage extends StatefulWidget {
  const BugDetailPage({
    super.key,
    required this.complaint,
  });

  final Complaint complaint;

  @override
  State<BugDetailPage> createState() => _BugDetailPageState();
}

class _BugDetailPageState extends State<BugDetailPage> {
  // automatically set status to acknowledged if it is currently pending
  @override
  void initState() {
    // This ensures that acknowledge complaint is called after
    // initState and build i.e the frame is completed
    // and context has been created
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      acknowledgeComplaint();
    });
    super.initState();
  }

  void acknowledgeComplaint() async {
    // if complaint state is pending meaning its a new complaint
    // the state should be automatically set as acknowledged.
    if (await getCurrentComplaintState(
          complaintID: widget.complaint.ticketNumber,
        ) ==
        ComplaintState.pending) {
      //State's mounted property
      if (mounted) {
        // this then notifies listeners
        context.read<ComplaintStateUpdates>().updateComplaintState(
              complaintID: widget.complaint.ticketNumber,
              newState: ComplaintState.acknowledged,
            );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Complaint acknowledged!",
              style: kContainerTextStyle.copyWith(color: Colors.black),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // watch ComponentStateUpdates for updates to complaint states
    // and rebuild
    context.watch<ComplaintStateUpdates>();

    // watch TaskStateUpdates for updates to task states
    // and rebuild
    context.watch<TaskStateUpdates>();

    //watch TaskUpdate for updates to tasks and rebuild
    context.watch<TasksUpdate>();

    return Scaffold(
      appBar: genericTaskBar("Bug Detail"),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: HeaderButton(
                        screenIsWide: true,
                        buttonText: "Update",
                        onPress: () async {
                          List<Tags>? currentTags = await retrieveTags(
                            complaintID: widget.complaint.ticketNumber,
                          );
                          List<Task> currentTasks =
                              await retrieveTasksByComplaint(
                            complaintID: widget.complaint.ticketNumber,
                          );

                          //loading staff source for the dropdown in task assignment form
                          await loadStaffSource();
                          if (context.mounted) {
                            SideSheet.right(
                              context: context,
                              width: constraints.maxWidth * 0.9,
                              sheetColor: lightAshyNavyBlue,
                              sheetBorderRadius: 10.0,
                              body: BugDetailUpdatePage(
                                constraints: constraints,
                                complaint: widget.complaint,
                                currentTags: currentTags,
                                currentTasks: currentTasks,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bug ID: ${widget.complaint.ticketNumber}",
                          style: kContainerTextStyle.copyWith(
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          "Date Created: ${convertToDateString(widget.complaint.dateCreated)}",
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
                      "Author: ${widget.complaint.author}",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Project: ${widget.complaint.associatedProject.name}",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Bug: ${widget.complaint.complaint}",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  /// Below is an expanded uneditable text field title "Complaint Notes" showing any additional notes from the user if
                  /// any else it says none
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 20.0,
                    ),
                    child: Text(
                      "Complaint Notes From Author${(widget.complaint.complaintNotes != null ? "" : ": None")}",
                      style: kContainerTextStyle,
                    ),
                  ),
                  if (widget.complaint.complaintNotes != null)
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
                              widget.complaint.complaintNotes!,
                              style: kContainerTextStyle.copyWith(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ///Files from user
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 20.0,
                    ),
                    child: Text("Files: ", style: kContainerTextStyle),
                  ),
                  buildComplaintFiles(
                      complaintID: widget.complaint.ticketNumber),

                  // Gets the actual state of the complaint when it is updated
                  FutureBuilder(
                    future: getCurrentComplaintState(
                      complaintID: widget.complaint.ticketNumber,
                    ),
                    builder: (BuildContext context,
                        AsyncSnapshot<ComplaintState> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CustomCircularProgressIndicator();
                      } else {
                        ComplaintState bugState = snapshot.data!;

                        /// All states of the complaints are available as chips and they are each grayed out or colored
                        /// based on the state of the complaint
                        /// Enums are compared with names because the hashCodes change as new objects are created
                        /// Since hashCodes are used in the equality comparison, the changing hashCodes can break it
                        return Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(20.0),
                              child:
                                  Text("Status: ", style: kContainerTextStyle),
                            ),
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
                                    bugState.name == ComplaintState.pending.name
                                        ? bugState.associatedColor
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
                                backgroundColor: bugState.name ==
                                        ComplaintState.acknowledged.name
                                    ? bugState.associatedColor
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
                                backgroundColor: bugState.name ==
                                        ComplaintState.inProgress.name
                                    ? bugState.associatedColor
                                    : Colors.grey.withAlpha(25),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Chip(
                                label: Text(
                                  "Completed",
                                  style: kContainerTextStyle.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                backgroundColor: bugState.name ==
                                        ComplaintState.completed.name
                                    ? bugState.associatedColor
                                    : Colors.grey.withAlpha(25),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),

                  // Gets the actual tags of the complaint when it is updated
                  FutureBuilder(
                    future: retrieveTags(
                        complaintID: widget.complaint.ticketNumber),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Tags>?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CustomCircularProgressIndicator();
                      } else {
                        List<Tags>? tags = snapshot.data;

                        /// Tags associated with the bug if available
                        return Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text("Tags: ", style: kContainerTextStyle),
                            ),
                            if (tags != null)
                              SizedBox(
                                width:
                                    determineContainerDimensionFromConstraint(
                                  constraintValue: constraints.maxWidth,
                                  subtractValue: 300,
                                ),
                                height: 70,
                                child: ListView.builder(
                                  itemCount: tags.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                      ),
                                      child: Chip(
                                        label: Text(
                                          tags[index].title,
                                          style: kContainerTextStyle.copyWith(
                                            color: Colors.black,
                                          ),
                                        ),
                                        backgroundColor:
                                            tags[index].associatedColor,
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ],
                        );
                      }
                    },
                  ),

                  /// Assigned Team i.e team lead and other staff
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 20.0,
                    ),
                    child: Text(
                      "Assigned Team",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  FutureBuilder(
                    future: loadTasksSourceByComplaint(
                        complaintID: widget.complaint.ticketNumber),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CustomCircularProgressIndicator();
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // team lead's task is then assured
                            if (tasksSource.isNotEmpty) ...[
                              ///Team Lead
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  top: 20.0,
                                ),
                                child: Text("Team Lead",
                                    style: kContainerTextStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: TaskPreviewCard(
                                    task: tasksSource
                                        .firstWhere((task) => task.isTeamLead)),
                              ),
                            ],

                            // taskSource length can be empty or 1 meaning no assigned staff
                            // or just team lead respectively
                            // this check ensures taskSource length is greater that 1 i.e team lead
                            if (tasksSource.length > 1) ...[
                              ///Team Members
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  top: 20.0,
                                ),
                                child: Text("Team Members",
                                    style: kContainerTextStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  height: 400,
                                  decoration: BoxDecoration(
                                    color: lightAshyNavyBlue,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  padding: const EdgeInsets.all(10.0),
                                  child: ListView.builder(
                                    itemCount: tasksSource.length - 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // taskSource without teamLead's task
                                      List<Task> nonTeamLeadTasks = tasksSource
                                          .where(
                                            (task) => task.isTeamLead == false,
                                          )
                                          .toList();
                                      return TaskPreviewCard(
                                        task: nonTeamLeadTasks[index],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ]
                          ],
                        );
                      }
                    },
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: constraints.maxHeight - 200 > 0
                          ? constraints.maxHeight - 200
                          : 0,
                      decoration: BoxDecoration(
                        color: lightAshyNavyBlue,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: buildStaffNotes(
                          complaintID: widget.complaint.ticketNumber,
                        ),
                      ),
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
