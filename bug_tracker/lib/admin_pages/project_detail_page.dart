import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/project.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/utilities/load_complaints_source.dart';
import 'package:bug_tracker/utilities/state_retrieval_functions.dart';
import 'package:bug_tracker/models/component_state_updates.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/ui_components/bug_preview_card.dart';
import 'package:bug_tracker/ui_components/empty_screen_placeholder.dart';
import 'package:bug_tracker/ui_components/custom_circular_progress_indicator.dart';

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({
    super.key,
    required this.project,
  });

  final Project project;

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  ProjectState? updatedProjectState;
  bool updateStatusIntent = false;

  @override
  Widget build(BuildContext context) {
    // watch ComponentStateUpdates for updates to complaint states
    // and rebuild
    context.watch<ComplaintStateUpdates>();

    // watch ProjectStateUpdates for updates to project states
    // and rebuild
    context.watch<ProjectStateUpdates>();

    return Scaffold(
      appBar: genericTaskBar("Project Detail"),
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
                          "Project ID: ${widget.project.id}",
                          style: kContainerTextStyle.copyWith(
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          "Date Created: ${convertToDateString(widget.project.dateCreated)}",
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
                          "Project: ${widget.project.name}",
                          style: kContainerTextStyle.copyWith(
                              fontSize: 25.0, color: Colors.white),
                        ),
                        if (widget.project.dateClosed != null)
                          Text(
                            "Date Closed: ${convertToDateString(widget.project.dateClosed!)}",
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
                      "Project Details: ",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 16.0,
                      ),
                    ),
                  ),

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
                          child: (widget.project.details != null)
                              ? Text(
                                  widget.project.details!,
                                  style: kContainerTextStyle.copyWith(
                                    fontSize: 15.0,
                                  ),
                                )
                              : const EmptyScreenPlaceholder(),
                        ),
                      ),
                    ),
                  ),

                  // Gets the actual state of the project when it is updated
                  FutureBuilder(
                    future:
                        getCurrentProjectState(projectID: widget.project.id),
                    builder: (BuildContext context,
                        AsyncSnapshot<ProjectState> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CustomCircularProgressIndicator();
                      } else {
                        ProjectState projectState = snapshot.data!;

                        /// All states of the projects are available as chips and they are each grayed out or colored
                        /// based on the state of the project
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
                                  "Open",
                                  style: kContainerTextStyle.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                backgroundColor:
                                    projectState.name == ProjectState.open.name
                                        ? projectState.associatedColor
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
                                backgroundColor: projectState.name ==
                                        ProjectState.postponed.name
                                    ? projectState.associatedColor
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
                                backgroundColor: projectState.name ==
                                        ProjectState.closed.name
                                    ? projectState.associatedColor
                                    : Colors.grey.withAlpha(25),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Chip(
                                label: Text(
                                  "Cancelled",
                                  style: kContainerTextStyle.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                backgroundColor: projectState.name ==
                                        ProjectState.cancelled.name
                                    ? projectState.associatedColor
                                    : Colors.grey.withAlpha(25),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),

                  /// Update project state to either cancel, postpone or close
                  if (updateStatusIntent) ...[
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
                        "Set project as open",
                        style: checkboxTextStyle,
                      ),
                      value: ProjectState.open,
                      groupValue: updatedProjectState,
                      onChanged: (value) {
                        setState(() {
                          updatedProjectState = value;
                        });
                      },
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
                      buttonText: updateStatusIntent ? "Done" : "Update Status",
                      onPress: () async {
                        // save to database if intent is there
                        if (updateStatusIntent) {
                          if (updatedProjectState != null) {
                            await context
                                .read<ProjectStateUpdates>()
                                .updateProjectState(
                                  projectID: widget.project.id,
                                  newState: updatedProjectState!,
                                );
                          }
                        }

                        // user sees update status or done corresponding to if the choices are shown or not
                        updateStatusIntent = !updateStatusIntent;
                        // redraw to show action first
                        setState(() {
                          // reset state for when next the choices are open
                          updatedProjectState = null;
                        });
                        // if this resolves to true now then it currently shows update status after done was previously clicked
                        // meaning the status has been updated
                        if (!updateStatusIntent) {
                          if (context.mounted) {
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
                      child: FutureBuilder(
                        future: loadComplaintsSourceByProject(
                          projectID: widget.project.id,
                        ),
                        builder: (BuildContext context,
                            AsyncSnapshot<void> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CustomCircularProgressIndicator(),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: complaintsSource.length,
                              itemBuilder: (BuildContext context, int index) {
                                return BugPreviewCard(
                                    complaint: complaintsSource[index]);
                              },
                            );
                          }
                        },
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
