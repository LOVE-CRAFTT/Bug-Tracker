class WorkSession {
  const WorkSession({
    required this.id,
    required this.startDate,
    required this.endDate,
  });

  final int id;
  final DateTime startDate;
  final DateTime? endDate;
}
