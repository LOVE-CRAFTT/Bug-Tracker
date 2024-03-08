import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/build_milestones_checkboxes.dart';
import 'package:bug_tracker/ui_components/header_button.dart';

Future buildTaskUpdatePage({
  required BuildContext context,
  required BoxConstraints constraints,
  required bool isTeamLead,
  required VoidCallback redraw,
}) {
  return SideSheet.right(
    context: context,
    width: constraints.maxWidth * 0.9,
    sheetColor: lightAshyNavyBlue,
    sheetBorderRadius: 10.0,
    body: TasksUpdatePage(
      maxHeight: constraints.maxHeight,
      maxWidth: constraints.maxWidth,
      isTeamLead: isTeamLead,
      redraw: redraw,
    ),
  );
}

///Text editing Controllers
TextEditingController transferTaskController = TextEditingController();
TextEditingController userNoteController = TextEditingController();

/// Separated this way so set-state can be accessed
class TasksUpdatePage extends StatefulWidget {
  const TasksUpdatePage({
    super.key,
    required this.maxHeight,
    required this.maxWidth,
    required this.isTeamLead,
    required this.redraw,
  });

  final double maxHeight;
  final double maxWidth;
  final bool isTeamLead;
  final VoidCallback redraw;

  @override
  State<TasksUpdatePage> createState() => _TasksUpdatePageState();
}

class _TasksUpdatePageState extends State<TasksUpdatePage> {
  bool taskCompleted = false;
  bool complaintCompleted = false;
  var dropDownValue = teamMembers.first;
  String transferTaskText = "";
  String noteToUser = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Mark task as completed
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
          ),

          /// Transfer tasks
          /// Comments and dropdown arranged in row
          makeTitle(title: "Transfer task"),
          SizedBox(
            height: determineContainerDimensionFromConstraint(
              constraintValue: widget.maxHeight,
              subtractValue: 300,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 15.0,
                    ),
                    child: TextField(
                      style: kContainerTextStyle.copyWith(
                        color: Colors.black,
                      ),
                      controller: transferTaskController,
                      decoration: InputDecoration(
                        hintText: "Comments",
                        hintStyle:
                            kContainerTextStyle.copyWith(color: Colors.black45),
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white70,
                      ),
                      expands: true,
                      maxLines: null,
                      onChanged: (text) {
                        transferTaskText = text;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: secondaryThemeColorBlue),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: DropdownButton(
                        value: dropDownValue,
                        items: teamMembers
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value!),
                              ),
                            )
                            .toList(),
                        onChanged: (selected) {
                          setState(() {
                            dropDownValue = selected;
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
                )
              ],
            ),
          ),

          /// Mark Complaint as completed if isTeamLead
          ///
          /// Title
          if (widget.isTeamLead)
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
          if (widget.isTeamLead) makeTitle(title: "Notes to User: "),
          if (widget.isTeamLead)
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
                  onChanged: (text) {
                    noteToUser = text;
                  },
                ),
              ),
            ),

          /// Once done is clicked navigator.pop and then redraw
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: HeaderButton(
                screenIsWide: true,
                buttonText: "Done",
                onPress: () {
                  Navigator.pop(context);
                  widget.redraw();
                  transferTaskController.clear();
                  userNoteController.clear();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

List teamMembers = [
  "Alan Broker",
  "Windsor Elizabeth",
  "Winston Churchill",
];

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
