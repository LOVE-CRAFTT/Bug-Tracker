import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

class TaskAssignmentForm extends StatelessWidget {
  const TaskAssignmentForm({
    super.key,
    required this.dropDownValue,
    required this.taskController,
    required this.onChange,
  });

  final String dropDownValue;
  final TextEditingController taskController;
  final void Function(dynamic)? onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          /// Team Lead
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: DropdownButton(
              value: dropDownValue,
              onChanged: onChange,
              items: teamMembers.map((member) {
                return DropdownMenuItem(
                  value: member,
                  child: Text(member),
                );
              }).toList(),
              focusColor: Colors.transparent,
            ),
          ),

          /// Team Lead Task
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

List<String> teamMembers = [
  "Alan Broker",
  "Windsor Elizabeth",
  "Winston Churchill",
];
