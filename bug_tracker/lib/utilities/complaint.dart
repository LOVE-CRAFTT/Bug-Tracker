import 'package:mysql1/mysql1.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/project.dart';

/// Complaint Class
class Complaint {
  const Complaint({
    required this.ticketNumber,
    required this.complaint,
    required this.complaintNotes,
    required this.complaintState,
    required this.associatedProject,
    required this.dateCreated,
    required this.author,
    required this.tags,
  });

  Complaint.fromResultRow({
    required ResultRow complaintRow,
    required Project project,
    required String author,
    required List<Tags>? tags,
  }) : this(
          ticketNumber: complaintRow['id'],
          complaint: complaintRow['title'],
          complaintNotes: complaintRow['notes']?.toString(),
          complaintState: ComplaintState.values.firstWhere(
            (state) => state.title == complaintRow['complaint_state'],
          ),
          associatedProject: project,
          dateCreated:
              DateTime.parse(complaintRow['date_created'].toString()).toLocal(),
          author: author,
          tags: tags,
        );

  final int ticketNumber;
  final String complaint;
  final String? complaintNotes;
  final ComplaintState complaintState;
  final Project associatedProject;
  final DateTime dateCreated;
  final String author;
  final List<Tags>? tags;
}
