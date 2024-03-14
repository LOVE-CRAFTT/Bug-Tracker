import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/staff_pages/task_page.dart';
import 'package:bug_tracker/ui_components/complaint.dart';

/// Widget to describe a complaint in the user page
/// Consists of a column with the ticket number, the complaint title and the associated project
class Task extends StatelessWidget {
  const Task({
    super.key,
    required this.task,
    required this.taskStatus,
    required this.complaint,
    required this.dueDate,
  });

  final Complaint complaint;
  final String task;
  final Status taskStatus;
  final DateTime dueDate;

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
              builder: (context) => TaskPage(
                isTeamLead: true,
                task: task,
                complaint: complaint,
                dueDate: convertToDateString(dueDate),
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
                      "Complaint ID: ${complaint.ticketNumber}",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      "Due date: ${convertToDateString(dueDate)}",
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
                    "Complaint: ${complaint.complaint}",
                    style: kContainerTextStyle,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Task: $task",
                      style: kContainerTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Chip(
                      label: Text(
                        taskStatus.title,
                        style: kContainerTextStyle.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: taskStatus.associatedColor,
                    ),
                  ],
                ),
                Text(
                  "Project: ${complaint.projectName}",
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
