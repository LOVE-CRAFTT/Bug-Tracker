import 'package:mysql1/mysql1.dart';
import 'package:bug_tracker/database/db.dart';
import 'package:bug_tracker/utilities/task.dart';
import 'package:bug_tracker/utilities/work_session.dart';

Future<List<WorkSession>> retrieveAllWorkSessions({required int taskID}) async {
  List<WorkSession> processedSessions = [];

  Results? results = await db.getAllWorkSessions(taskID: taskID);
  if (results != null) {
    for (ResultRow sessionRow in results) {
      processedSessions.add(
        WorkSession(
          id: sessionRow['id'],
          startDate:
              DateTime.parse(sessionRow['time_started'].toString()).toLocal(),
          endDate: sessionRow['time_ended'] != null
              ? DateTime.parse(sessionRow['time_ended'].toString()).toLocal()
              : null,
        ),
      );
    }
    return processedSessions;
  } else {
    return [];
  }
}

Future<WorkSession?> retrieveActiveWorkSession({required int taskID}) async {
  Results? result = await db.getActiveWorkSession(taskID: taskID);
  if (result == null) {
    // No active session
    return null;
  } else {
    // There is an active work session
    ResultRow sessionRow = result.first;

    return WorkSession(
      id: sessionRow['id'],
      startDate:
          DateTime.parse(sessionRow['time_started'].toString()).toLocal(),
      endDate: sessionRow['time_ended'] != null
          ? DateTime.parse(sessionRow['time_ended'].toString()).toLocal()
          : null,
    );
  }
}

Future<WorkSession?> startWorkSession({required Task task}) async {
  int? newWorkSessionID = await db.addWorkSession(task: task);

  if (newWorkSessionID != null) {
    return WorkSession(
      id: newWorkSessionID,
      startDate: DateTime.now(),
      endDate: null,
    );
  } else {
    return null;
  }
}

Future<bool> endWorkSession({required int sessionID}) async {
  return await db.updateSessionEndTime(sessionID: sessionID);
}
