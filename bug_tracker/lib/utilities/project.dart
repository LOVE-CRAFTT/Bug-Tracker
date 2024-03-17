import 'package:bug_tracker/utilities/constants.dart';

class Project {
  const Project({
    required this.id,
    required this.name,
    required this.state,
    required this.dateCreated,
    this.dateClosed,
  });

  final int id;
  final String name;
  final ProjectState state;
  final DateTime dateCreated;
  final DateTime? dateClosed;
}
