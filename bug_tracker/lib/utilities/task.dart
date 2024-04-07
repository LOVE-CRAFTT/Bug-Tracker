import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/utilities/staff.dart';
import 'package:mysql1/mysql1.dart';

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

  Task.fromResultRow({
    required ResultRow taskRow,
    required Complaint associatedComplaint,
    required Staff assignedStaff,
  }) : this(
          id: taskRow['id'],
          task: taskRow['task_name'],
          taskState: TaskState.values.firstWhere(
            (state) => state.title == taskRow['task_state'],
          ),
          associatedComplaint: associatedComplaint,
          dueDate: taskRow['due_date'],
          assignedStaff: assignedStaff,
          isTeamLead: taskRow['is_team_lead'] == 1 ? true : false,
        );

  final int id;
  final Complaint associatedComplaint;
  final String task;
  final TaskState taskState;
  final DateTime dueDate;
  final Staff assignedStaff;
  final bool isTeamLead;
}
