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
    taskState: TaskState.newTask,
  ),
  Task(
    complaint: complaintsSource[1],
    task: "Ascertain from user files if user is premium user",
    taskState: TaskState.inProgress,
  ),
  Task(
    complaint: complaintsSource[1],
    task: "Replicate issue in main branch",
    taskState: TaskState.dueToday,
  ),
  Task(
    complaint: complaintsSource[2],
    task: "Figure out which other types of phone numbers don't work",
    taskState: TaskState.completed,
  ),
  Task(
    complaint: complaintsSource[3],
    task: "Try to obtain the device specifications from user files",
    taskState: TaskState.overdue,
  ),
];
