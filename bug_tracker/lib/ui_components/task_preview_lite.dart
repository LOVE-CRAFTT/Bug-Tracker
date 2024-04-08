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
  });

  final Task task;

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

          /// due date and state
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                convertToDateString(task.dueDate),
                style: kContainerTextStyle.copyWith(
                  fontSize: 12.0,
                ),
              ),
              Chip(
                label: Text(
                  task.taskState.title,
                  style: kContainerTextStyle.copyWith(
                    color: Colors.black,
                  ),
                ),
                backgroundColor: task.taskState.associatedColor,
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskDetailPage(
                  task: task,
                  viewingFromBug: false,
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
