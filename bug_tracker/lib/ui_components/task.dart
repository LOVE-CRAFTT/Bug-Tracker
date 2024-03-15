import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/complaint.dart';

/// Task Class
class Task {
  const Task({
    required this.task,
    required this.taskState,
    required this.complaint,
    required this.dueDate,
  });

  final Complaint complaint;
  final String task;
  final TaskState taskState;
  final DateTime dueDate;
}
