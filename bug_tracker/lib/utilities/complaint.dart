import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/project.dart';

/// Complaint Class
class Complaint {
  const Complaint({
    required this.ticketNumber,
    required this.complaint,
    this.complaintNotes,
    required this.complaintState,
    required this.associatedProject,
    required this.dateCreated,
    required this.author,
    this.tags,
  });

  final int ticketNumber;
  final String complaint;
  final String? complaintNotes;
  final ComplaintState complaintState;
  final Project associatedProject;
  final DateTime dateCreated;
  final String author;
  final List<Tags>? tags;
}
