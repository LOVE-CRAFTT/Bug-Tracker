import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/task.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/build_complaints.dart';

ListView buildTasks() {
  return ListView.builder(
    itemCount: tasksSource.length,
    itemBuilder: (BuildContext context, int index) {
      return tasksSource[index];
    },
  );
}

List tasksSource = [
  Task(
    complaint: complaintsSource[0],
    task: "Run Youtube main branch in sandbox to replicate issue",
    taskStatus: Status.fresh,
    dueDate: DateTime(2024, 2, 13),
  ),
  Task(
    complaint: complaintsSource[1],
    task: "Ascertain from user files if user is premium user",
    taskStatus: Status.inProgress,
    dueDate: DateTime(2023, 2, 13),
  ),
  Task(
    complaint: complaintsSource[1],
    task: "Replicate issue in main branch",
    taskStatus: Status.dueToday,
    dueDate: DateTime(2024, 3, 4),
  ),
  Task(
    complaint: complaintsSource[2],
    task: "Figure out which other types of phone numbers don't work",
    taskStatus: Status.completed,
    dueDate: DateTime(2024, 2, 13),
  ),
  Task(
    complaint: complaintsSource[3],
    task: "Try to obtain the device specifications from user files",
    taskStatus: Status.overdue,
    dueDate: DateTime(2024, 1, 1),
  ),
];
