import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/complaint.dart';

/// Task Class
class Task {
  const Task({
    required this.task,
    required this.taskState,
    required this.complaint,
    required this.dueDate,
    required this.assignedStaff,
    required this.assignedStaffInitials,
  });

  final Complaint complaint;
  final String task;
  final TaskState taskState;
  final DateTime dueDate;
  final String assignedStaff;
  final String assignedStaffInitials;
}
