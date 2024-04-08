import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/load_complaints_source.dart';
import 'package:mysql1/mysql1.dart';
import 'package:bug_tracker/database/db.dart';
import 'package:bug_tracker/utilities/task.dart';
import 'package:bug_tracker/utilities/staff.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';

Future<void> loadTasksSourceByComplaint({required int complaintID}) async {
  List<Task> processedTasks = [];

  // get tasks by associated complaint from database
  Results? results = await db.getTasksByComplaint(complaintID: complaintID);

  //if there are associated tasks
  if (results != null) {
    // process them into task classes
    for (ResultRow taskRow in results) {
      // get assigned staff here since can't await in constructor
      Results? staffResult =
          await db.getStaffDataUsingID(taskRow['associated_staff']);
      ResultRow? staffRow = staffResult?.first;

      processedTasks.add(
        Task.fromResultRow(
          taskRow: taskRow,
          // if tasks are being viewed as a result of this function then
          // the complaintsSource has already been loaded even if it is sorted
          // since all complaints/bugs are retrieved from the complaintsSource list
          associatedComplaint: complaintsSource.firstWhere(
            (complaint) =>
                complaint.ticketNumber == taskRow['associated_complaint'],
          ),
          assignedStaff: Staff.fromResultRow(staffRow: staffRow!),
        ),
      );
    }
    tasksSource = processedTasks;
  }
  // if no tasks
  else {
    tasksSource = [];
  }
}

Future<void> loadTasksSourceByStaff({
  required int staffID,
  required int limit,
}) async {
  List<Task> processedTasks = [];

  // load all complaints for Task object creation
  // no limit so all complaints can be searched
  await loadComplaintsSource(limit: impossiblyLargeNumber);

  // get tasks by associated staff from database
  Results? results = await db.getTasksByStaff(staffID: staffID, limit: limit);

  // get assigned staff here since can't await in constructor
  Results? staffResult = await db.getStaffDataUsingID(staffID);
  ResultRow? staffRow = staffResult?.first;

  //if there are associated tasks
  if (results != null) {
    // process them into task classes
    for (ResultRow taskRow in results) {
      processedTasks.add(
        Task.fromResultRow(
          taskRow: taskRow,
          associatedComplaint: complaintsSource.firstWhere(
            (complaint) =>
                complaint.ticketNumber == taskRow['associated_complaint'],
          ),
          assignedStaff: Staff.fromResultRow(staffRow: staffRow!),
        ),
      );
    }
    tasksSource = processedTasks;
  }
  // if no tasks
  else {
    tasksSource = [];
  }
}

// work around to retrieve tasks by complaint
Future<List<Task>> retrieveTasksByComplaint({required int complaintID}) async {
  await loadTasksSourceByComplaint(complaintID: complaintID);
  return tasksSource;
}

// work around to retrieve tasks by staff
Future<List<Task>> retrieveTasksByStaff({required int staffID}) async {
  await loadTasksSourceByStaff(staffID: staffID, limit: impossiblyLargeNumber);
  return tasksSource;
}
