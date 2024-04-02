import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/staff_pages/task_detail_page.dart';
import 'package:bug_tracker/utilities/task.dart';

/// "Lite" version of the task preview card for the admin homepage
class TaskPreviewLite extends StatelessWidget {
  const TaskPreviewLite({
    super.key,
    required this.task,
    required this.index,
  });

  final Task task;

  /// TODO: clean later
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          /// task/bug
          title: Text(task.task),
          titleTextStyle: kContainerTextStyle.copyWith(
            color: Colors.white,
            fontSize: 20.0,
          ),

          /// complaint
          subtitle: Text(task.associatedComplaint.complaint),
          subtitleTextStyle: kContainerTextStyle.copyWith(
            fontSize: 12.0,
          ),

          /// due date
          trailing: Text(
            convertToDateString(task.dueDate),
            style: kContainerTextStyle.copyWith(
              fontSize: 12.0,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskDetailPage(
                  taskId: task.id,
                  isTeamLead: index == 1 ? true : false,
                  task: task.task,
                  complaint: task.associatedComplaint,
                  dueDate: convertToDateString(task.dueDate),
                ),
              ),
            );
          },
        ),
        const Divider(
          color: Color(0xFFb6b8aa),
          thickness: 0.2,
        )
      ],
    );
  }
}
