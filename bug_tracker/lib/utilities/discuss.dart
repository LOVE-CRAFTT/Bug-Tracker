import 'package:bug_tracker/utilities/staff.dart';

class Discuss {
  const Discuss({
    required this.id,
    required this.title,
    required this.participants,
  });

  final int id;
  final String title;
  final List<Staff> participants;
}
