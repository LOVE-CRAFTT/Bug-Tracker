import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/task_assignment_form.dart';
import 'package:bug_tracker/ui_components/header_button.dart';

class BugDetailUpdatePage extends StatefulWidget {
  const BugDetailUpdatePage({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  State<BugDetailUpdatePage> createState() => _BugDetailUpdatePageState();
}

class _BugDetailUpdatePageState extends State<BugDetailUpdatePage> {
  // This should receive the tags from the bug detail page so
  // that it can check against the list for drawing

  /// List of tasks and drop down values (for team members)
  List<TextEditingController> teamMembersTaskControllers = [];
  List<String> teamMemberValues = [];

  /// Task and drop down value for team lead
  TextEditingController teamLeadTaskController = TextEditingController();
  String teamLeadValue = teamMembers.first;

  /// selected tags
  List<bool> selectedTags = List.filled(Tags.values.length, false);

  ///
  bool showTeamSection = false;

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
                        selected: selectedTags[index],
                        onSelected: (bool value) {
                          setState(() {
                            selectedTags[index] = value;
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

            // Button to add a new team member
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  textStyle: kContainerTextStyle,
                ),
                onPressed: () {
                  setState(
                    () {
                      teamMembersTaskControllers.add(TextEditingController());
                      teamMemberValues.add(teamMembers.first);
                    },
                  );
                },
                child: const Text('Add Team Member'),
              ),
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
                onPress: () {
                  /// Store in database
                  /// set taskState as updated if necessary
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
