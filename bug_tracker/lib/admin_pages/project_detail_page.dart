import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/ui_components/bug_preview_card.dart';
import 'package:bug_tracker/utilities/build_complaints.dart';

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({
    super.key,
    required this.projectID,
    required this.projectName,
    required this.projectDetails,
    required this.projectState,
    required this.dateCreated,
    required this.dateClosed,
  });

  final int projectID;
  final String projectName;
  final String? projectDetails;
  final String dateCreated;
  final ProjectState projectState;
  final String? dateClosed;

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  ProjectState? updatedProjectState = ProjectState.open;
  bool updateProjectIntent = false;

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
                  /// Project ID and date Created
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Project ID: ${widget.projectID}",
                          style: kContainerTextStyle.copyWith(
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          "Date Created: ${widget.dateCreated}",
                          style: kContainerTextStyle.copyWith(
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Project: ${widget.projectName}",
                          style: kContainerTextStyle.copyWith(
                              fontSize: 25.0, color: Colors.white),
                        ),
                        if (widget.dateClosed != null)
                          Text(
                            "Date Closed: ${widget.dateClosed}",
                            style: kContainerTextStyle.copyWith(
                              fontSize: 14.0,
                            ),
                          ),
                      ],
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
                      "Project Details${(widget.projectDetails != null ? "" : ": None")}",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  if (widget.projectDetails != null)
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
                              widget.projectDetails!,
                              style: kContainerTextStyle.copyWith(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  /// All states of the projects are available as chips and they are each grayed out or colored
                  /// based on the state of the project
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
                            "Open",
                            style: kContainerTextStyle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          backgroundColor:
                              widget.projectState.name == ProjectState.open.name
                                  ? widget.projectState.associatedColor
                                  : Colors.grey.withAlpha(25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Chip(
                          label: Text(
                            "Postponed",
                            style: kContainerTextStyle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          backgroundColor: widget.projectState.name ==
                                  ProjectState.postponed.name
                              ? widget.projectState.associatedColor
                              : Colors.grey.withAlpha(25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Chip(
                          label: Text(
                            "Closed",
                            style: kContainerTextStyle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          backgroundColor: widget.projectState.name ==
                                  ProjectState.closed.name
                              ? widget.projectState.associatedColor
                              : Colors.grey.withAlpha(25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Chip(
                          label: Text(
                            "Cancelled",
                            style: kContainerTextStyle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          backgroundColor: widget.projectState.name ==
                                  ProjectState.cancelled.name
                              ? widget.projectState.associatedColor
                              : Colors.grey.withAlpha(25),
                        ),
                      ),
                    ],
                  ),

                  /// Update project state to either cancel, postpone or close
                  if (updateProjectIntent) ...[
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 20.0,
                      ),
                      child: Text("Update Status", style: kContainerTextStyle),
                    ),
                    RadioListTile(
                      title: Text(
                        "Set project as postponed",
                        style: checkboxTextStyle,
                      ),
                      value: ProjectState.postponed,
                      groupValue: updatedProjectState,
                      onChanged: (value) {
                        setState(() {
                          updatedProjectState = value;
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text(
                        "Set project as cancelled",
                        style: checkboxTextStyle,
                      ),
                      value: ProjectState.cancelled,
                      groupValue: updatedProjectState,
                      onChanged: (value) {
                        setState(() {
                          updatedProjectState = value;
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text(
                        "Set project as closed",
                        style: checkboxTextStyle,
                      ),
                      value: ProjectState.closed,
                      groupValue: updatedProjectState,
                      onChanged: (value) {
                        setState(() {
                          updatedProjectState = value;
                        });
                      },
                    ),
                  ],
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: HeaderButton(
                      screenIsWide: true,
                      buttonText:
                          updateProjectIntent ? "Done" : "Update Status",
                      onPress: () {
                        // user sees update status or done corresponding to if the choices are shown or not
                        updateProjectIntent = !updateProjectIntent;
                        // redraw to show action first
                        setState(() {
                          // reset state for when next the choices are open
                          updatedProjectState = ProjectState.open;

                          ///save to database
                        });
                        // if this resolves to true now then it currently shows update status after done was previously clicked
                        // meaning the status has been updated
                        if (!updateProjectIntent) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Update successful",
                                style: kContainerTextStyle.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),

                  ///Bugs related to the project
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 20.0,
                    ),
                    child: Text("Bugs", style: kContainerTextStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                        color: lightAshyNavyBlue,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: buildBugPreviewCards(),
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

ListView buildBugPreviewCards() {
  return ListView.builder(
    itemCount: complaintsSource.length,
    itemBuilder: (BuildContext context, int index) {
      return DetailPageBugPreviewCard(complaint: complaintsSource[index]);
    },
  );
}
