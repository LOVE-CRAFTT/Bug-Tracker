import 'package:bug_tracker/utilities/constants.dart';

/// Complaint Class
class Complaint {
  const Complaint({
    required this.ticketNumber,
    required this.complaint,
    required this.complaintState,
    required this.projectName,
    required this.dateCreated,
    required this.reporter,
    this.teamLead,
    this.teamMembers,
    this.tags,
  });

  final int ticketNumber;
  final String complaint;
  final ComplaintState complaintState;
  final String projectName;
  final DateTime dateCreated;
  final String reporter;
  final String? teamLead;
  final List<String>? teamMembers;
  final Tags? tags;
}
