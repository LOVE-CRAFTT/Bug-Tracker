import 'package:bug_tracker/utilities/task.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/utilities/project.dart';
import 'package:bug_tracker/utilities/staff.dart';

/// All these are the central data sources
/// that data will be populated and retrieved from

// Main complaint source.
List<Complaint> complaintsSource = [];

// Main task source
List<Task> tasksSource = [];

// Main Project source
List<Project> projectSource = [];

// Main staff Source
List<Staff> staffSource = [];

// Main staff Note source
List<String> staffNotesSource = [];
