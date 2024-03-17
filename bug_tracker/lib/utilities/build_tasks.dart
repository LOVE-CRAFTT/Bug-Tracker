import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/task.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/build_complaints.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/build_staff.dart';
import 'package:bug_tracker/staff_pages/task_page.dart';

ListView buildTasks({required bool isTeamLead}) {
  return ListView.builder(
    itemCount: tasksSource.length,
    itemBuilder: (BuildContext context, int index) {
      Task task = tasksSource[index];
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
                  isTeamLead: isTeamLead,
                  task: task.task,
                  complaint: task.complaint,
                  dueDate: convertToDateString(task.dueDate),
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
                        "Complaint ID: ${task.complaint.ticketNumber}",
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
                      "Complaint: ${task.complaint.complaint}",
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
                    "Project: ${task.complaint.associatedProject.name}",
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
    },
  );
}

List tasksSource = [
  Task(
    complaint: complaintsSource[0],
    task: "Run Youtube main branch in sandbox to replicate issue",
    taskState: TaskState.fresh,
    dueDate: DateTime(2024, 2, 13),
    assignedStaff: staffSource[0],
  ),
  Task(
    complaint: complaintsSource[1],
    task: "Ascertain from user files if user is premium user",
    taskState: TaskState.inProgress,
    dueDate: DateTime(2023, 2, 13),
    assignedStaff: staffSource[1],
  ),
  Task(
    complaint: complaintsSource[1],
    task: "Replicate issue in main branch",
    taskState: TaskState.dueToday,
    dueDate: DateTime(2024, 3, 4),
    assignedStaff: staffSource[2],
  ),
  Task(
    complaint: complaintsSource[2],
    task: "Figure out which other types of phone numbers don't work",
    taskState: TaskState.completed,
    dueDate: DateTime(2024, 2, 13),
    assignedStaff: staffSource[3],
  ),
  Task(
    complaint: complaintsSource[4],
    task: "Try to obtain the device specifications from user files",
    taskState: TaskState.overdue,
    dueDate: DateTime(2024, 1, 1),
    assignedStaff: staffSource[0],
  ),
];
