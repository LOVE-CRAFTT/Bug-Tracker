import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/task.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/staff_pages/task_detail_page.dart';

/// Naming convention in this project dictates a difference between overview and preview cards
/// Overview cards are for when the card contents are the "main focus" of that view/context
/// For example [TaskOverviewCard] is what staff sees however, the admin sees the [TaskPreviewCard] in the bug_detail_page
///
/// Preview cards are the opposite of Overview cards
class TaskOverviewCard extends StatelessWidget {
  const TaskOverviewCard({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      child: InkWell(
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
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: secondaryThemeColorBlue,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Complaint ID: ${task.associatedComplaint.ticketNumber}",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      "Due date: ${convertToDateString(task.dueDate)}",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2.0,
                  ),
                  child: Text(
                    "Complaint: ${task.associatedComplaint.complaint}",
                    style: kContainerTextStyle,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Task: ${task.task}",
                      style: kContainerTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 18,
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
                Text(
                  "Project: ${task.associatedComplaint.associatedProject.name}",
                  style: kContainerTextStyle.copyWith(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
