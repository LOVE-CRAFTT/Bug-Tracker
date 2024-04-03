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

  final int id;
  final Complaint associatedComplaint;
  final String task;
  final TaskState taskState;
  final DateTime dueDate;
  final Staff assignedStaff;
  final bool isTeamLead;
}
