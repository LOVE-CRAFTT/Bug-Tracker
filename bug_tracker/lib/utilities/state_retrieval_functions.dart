import 'dart:async';
import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/database/db.dart';
import 'package:bug_tracker/utilities/constants.dart';

Future<ComplaintState> getCurrentComplaintState(
    {required int complaintID}) async {
  // to be returned
  ComplaintState complaintState;

  Results? result = await db.getComplaintData(complaintID);

  // if there is such a complaint
  if (result != null) {
    complaintState = ComplaintState.values.firstWhere(
      (state) => state.title == result.first['complaint_state'],
    );
  }
  // error retrieving the state return pending and debugPrint error
  else {
    debugPrint("Error getting complaint state");
    complaintState = ComplaintState.pending;
  }

  return complaintState;
}

Future<TaskState> getCurrentTaskState({required int taskID}) async {
  // to be returned
  TaskState taskState;

  Results? result = await db.getTaskData(taskID);

  // if there is such a task
  if (result != null) {
    taskState = TaskState.values.firstWhere(
      (state) => state.title == result.first['task_state'],
    );
  }
  // error retrieving the state return pending and debugPrint error
  else {
    debugPrint("Error getting task state");
    taskState = TaskState.inProgress;
  }

  return taskState;
}

Future<ProjectState> getCurrentProjectState({required int projectID}) async {
  // to be returned
  ProjectState projectState;

  Results? result = await db.getProjectData(projectID);

  // if there is such a project
  if (result != null) {
    projectState = ProjectState.values.firstWhere(
      (state) => state.title == result.first['project_state'],
    );
  }
  // error retrieving the state return pending and debugPrint error
  else {
    debugPrint("Error getting project state");
    projectState = ProjectState.cancelled;
  }

  return projectState;
}
