import 'package:bug_tracker/utilities/constants.dart';

/// Complaint Class
class Complaint {
  const Complaint({
    required this.ticketNumber,
    required this.complaint,
    this.complaintNotes,
    required this.complaintState,
    required this.projectName,
    required this.dateCreated,
    required this.author,
    this.teamLead,
    this.teamMembers,
    this.tags,
  });

  final int ticketNumber;
  final String complaint;
  final String? complaintNotes;
  final ComplaintState complaintState;
  final String projectName;
  final DateTime dateCreated;
  final String author;
  final String? teamLead;
  final List<String>? teamMembers;
  final List<Tags>? tags;
}
