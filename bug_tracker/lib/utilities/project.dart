import 'package:mysql1/mysql1.dart';
import 'package:bug_tracker/utilities/constants.dart';

class Project {
  const Project({
    required this.id,
    required this.name,
    required this.details,
    required this.state,
    required this.dateCreated,
    required this.dateClosed,
  });

  Project.fromResultRow({required ResultRow projectRow})
      : this(
          id: projectRow['id'],
          name: projectRow['name'],
          details: projectRow['details']?.toString(),
          state: ProjectState.values.firstWhere(
            (state) => state.title == projectRow['project_state'],
          ),
          dateCreated: projectRow['date_created'],
          dateClosed: projectRow['date_closed'],
        );

  final int id;
  final String name;
  final String? details;
  final ProjectState state;
  final DateTime dateCreated;
  final DateTime? dateClosed;
}
