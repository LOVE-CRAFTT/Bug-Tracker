import 'package:bug_tracker/utilities/build_tasks.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/build_complaint_notes.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/ui_components/staff_task_card.dart';

class BugDetailPage extends StatelessWidget {
  const BugDetailPage({
    super.key,
    required this.ticketNumber,
    required this.projectName,
    required this.bug,
    required this.bugNotes,
    required this.bugState,
    required this.dateCreated,
    required this.author,
    this.tags,
  });

  final int ticketNumber;
  final String projectName;
  final String bug;
  final String? bugNotes;
  final String author;
  final String dateCreated;
  final ComplaintState bugState;
  final List<Tags>? tags;

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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: HeaderButton(
                          screenIsWide: true,
                          buttonText: "Update",
                          onPress: () {
                            //open admin update bug page
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bug ID: $ticketNumber",
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
                      "Author: $author",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Project: $projectName",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Bug: $bug",
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
                      "Complaint Notes From Author${(bugNotes != null ? "" : ": None")}",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  if (bugNotes != null)
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
                              bugNotes!,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      height: 100,
                      child: buildFilesPlaceHolders(),
                    ),
                  ),

                  /// All states of the complaints are available as chips and they are each grayed out or colored
                  /// based on the state of the complaint
                  /// Enums are compared with names because the hashCodes change as new objects are created
                  /// Since hashCodes are used in the equality comparison, the changing hashCodes can break it
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text("Status: ", style: kContainerTextStyle),
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
                          backgroundColor:
                              bugState.name == ComplaintState.acknowledged.name
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
                          backgroundColor:
                              bugState.name == ComplaintState.inProgress.name
                                  ? bugState.associatedColor
                                  : Colors.grey.withAlpha(25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Chip(
                          label: Text(
                            "Completed",
                            style: kContainerTextStyle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          backgroundColor:
                              bugState.name == ComplaintState.completed.name
                                  ? bugState.associatedColor
                                  : Colors.grey.withAlpha(25),
                        ),
                      ),
                    ],
                  ),

                  /// Tags associated with the bug if available
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text("Tags: ", style: kContainerTextStyle),
                      ),
                      if (tags != null)
                        SizedBox(
                          width: determineContainerDimensionFromConstraint(
                            constraintValue: constraints.maxWidth,
                            subtractValue: 300,
                          ),
                          height: 70,
                          child: ListView.builder(
                            itemCount: tags!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: Chip(
                                  label: Text(
                                    tags![index].title,
                                    style: kContainerTextStyle.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  backgroundColor: tags![index].associatedColor,
                                ),
                              );
                            },
                          ),
                        ),
                    ],
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

                  ///Team Lead
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 20.0,
                    ),
                    child: Text("Team Lead", style: kContainerTextStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: StaffTaskCard(task: tasksSource[0]),
                  ),

                  ///Team Members
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 20.0,
                    ),
                    child: Text("Team Members", style: kContainerTextStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: lightAshyNavyBlue,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: buildOtherStaffTaskCards(),
                    ),
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
                        child: buildNotes(),
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

/// Will replace with real files later
ListView buildFilesPlaceHolders() {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 4,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
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

ListView buildOtherStaffTaskCards() {
  return ListView.builder(
    itemCount: tasksSource.length,
    itemBuilder: (BuildContext context, int index) {
      return StaffTaskCard(task: tasksSource[index]);
    },
  );
}
