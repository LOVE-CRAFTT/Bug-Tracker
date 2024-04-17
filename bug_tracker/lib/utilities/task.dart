import 'package:mysql1/mysql1.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/utilities/staff.dart';

/// Task Class
class Task {
  const Task({
    required this.id,
    required this.task,
    required this.taskState,
    required this.associatedComplaint,
    required this.dueDate,
    required this.assignedStaff,
    required this.isTeamLead,
  });

  // implemented as factory to allow for state change
  // to dueToday or Overdue
  factory Task.fromResultRow({
    required ResultRow taskRow,
    required Complaint associatedComplaint,
    required Staff assignedStaff,
  }) {
    // Temporary value, might be overwritten
    TaskState taskState = TaskState.values.firstWhere(
      (state) => state.title == taskRow['task_state'],
    );

    // Overwrite the taskState based on the conditions if it is not completed
    if (taskState != TaskState.completed) {
      DateTime dueDate =
          DateTime.parse(taskRow['due_date'].toString()).toLocal();
      if (dueDate.day == DateTime.now().day &&
          dueDate.month == DateTime.now().month &&
          dueDate.year == DateTime.now().year) {
        taskState = TaskState.dueToday;
      } else if (dueDate.isBefore(DateTime.now())) {
        taskState = TaskState.overdue;
      }
    }

    return Task(
      id: taskRow['id'],
      task: taskRow['task_name'],
      taskState: taskState,
      associatedComplaint: associatedComplaint,
      dueDate: DateTime.parse(taskRow['due_date'].toString()).toLocal(),
      assignedStaff: assignedStaff,
      isTeamLead: taskRow['is_team_lead'] == 1 ? true : false,
    );
  }

  final int id;
  final Complaint associatedComplaint;
  final String task;
  final TaskState taskState;
  final DateTime dueDate;
  final Staff assignedStaff;
  final bool isTeamLead;
}
