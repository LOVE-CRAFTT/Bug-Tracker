import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/task.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/staff_pages/task_detail_page.dart';

/// Naming convention in this project dictates a difference between overview and preview cards
/// Overview cards are for when the card contents are the "main focus" of that view/context
/// For example [TaskOverviewCard] is what staff sees however, the admin sees the [TaskPreviewCard] in the bug_detail_page
///
/// Preview cards are the opposite of Overview cards
class TaskPreviewCard extends StatelessWidget {
  const TaskPreviewCard({
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
        title: Text(
          "${task.assignedStaff.surname} ${task.assignedStaff.firstName ?? ""} ${task.assignedStaff.middleName ?? ""}",
        ),
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
              builder: (context) => TaskDetailPage(
                ///isTeamLead should always be false for when admin is viewing tasks from bug page
                isTeamLead: true,
                task: task.task,
                complaint: task.associatedComplaint,
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
