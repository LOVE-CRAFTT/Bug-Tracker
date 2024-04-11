import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/staff.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';

class TaskAssignmentForm extends StatelessWidget {
  const TaskAssignmentForm({
    super.key,
    required this.dropDownValue,
    required this.taskController,
    required this.onChange,
  });

  final Staff? dropDownValue;
  final TextEditingController taskController;
  final void Function(Staff?)? onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          /// Staff
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: DropdownButton(
              value: dropDownValue,
              onChanged: onChange,
              items: staffSource.map((staff) {
                return DropdownMenuItem(
                  value: staff,
                  child: Text(
                    getFullNameFromNames(
                      surname: staff.surname,
                      firstName: staff.firstName,
                      middleName: staff.middleName,
                    ),
                  ),
                );
              }).toList(),
              focusColor: Colors.transparent,
            ),
          ),

          /// Task
          Expanded(
            child: TextField(
              controller: taskController,
              decoration: const InputDecoration(
                hintText: "Task",
                hintStyle: kContainerTextStyle,
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
