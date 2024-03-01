import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/build_milestones_checkboxes.dart';

Future buildTaskUpdatePage({
  required BuildContext context,
  required BoxConstraints constraints,
}) {
  return SideSheet.right(
    context: context,
    width: constraints.maxWidth * 0.9,
    sheetColor: lightAshyNavyBlue,
    sheetBorderRadius: 10.0,
    body: TasksUpdatePage(
      maxHeight: constraints.maxHeight,
      maxWidth: constraints.maxWidth,
    ),
  );
}

/// Separated this way so set-state can be accessed
class TasksUpdatePage extends StatefulWidget {
  const TasksUpdatePage({
    super.key,
    required this.maxHeight,
    required this.maxWidth,
  });

  final double maxHeight;
  final double maxWidth;

  @override
  State<TasksUpdatePage> createState() => _TasksUpdatePageState();
}

class _TasksUpdatePageState extends State<TasksUpdatePage> {
  final formKey = GlobalKey<FormState>();
  bool taskCompleted = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: SizedBox(
          height: widget.maxHeight,
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
            ],
          ),
        ),
      ),
    );
  }
}
