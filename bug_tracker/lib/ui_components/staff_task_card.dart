import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/task.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/staff_pages/task_page.dart';

class StaffTaskCard extends StatelessWidget {
  const StaffTaskCard({
    super.key,
    required this.task,
  });
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          child: Text(task.assignedStaff.initials),
        ),
        // e.g Kenny McCormack opened Milestone
        title: Text(task.assignedStaff.name),
        titleTextStyle: kContainerTextStyle.copyWith(fontSize: 12.0),
        subtitle: Text("Task: ${task.task}"),
        subtitleTextStyle: kContainerTextStyle.copyWith(fontSize: 18.0),
        trailing: Chip(
          label: Text(
            task.taskState.title,
            style: kContainerTextStyle.copyWith(
              color: Colors.black,
            ),
          ),
          backgroundColor: task.taskState.associatedColor,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskPage(
                ///isTeamLead should always be false for when admin is viewing tasks from bug page
                isTeamLead: true,
                task: task.task,
                complaint: task.complaint,
                dueDate: convertToDateString(task.dueDate),
                viewingFromBug: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
