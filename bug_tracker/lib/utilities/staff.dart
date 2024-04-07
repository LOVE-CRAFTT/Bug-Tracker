import 'package:mysql1/mysql1.dart';

class Staff {
  Staff({
    required this.id,
    required this.surname,
    required this.firstName,
    required this.middleName,
    required this.email,
  }) : initials = ((firstName != null ? firstName[0] : '') + (surname[0]))
            .toUpperCase();

  Staff.fromResultRow({
    required ResultRow staffRow,
  }) : this(
          id: staffRow['id'],
          surname: staffRow['surname'],
          firstName: staffRow['first_name'],
          middleName: staffRow['middle_name'],
          email: staffRow['email'],
        );

  final int id;
  final String surname;
  final String? firstName;
  final String? middleName;
  final String initials;
  final String email;

  // override equality operator to use id
  // to prevent errors due to comparisons between Staff with
  // same hashcode but different ids
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Staff && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
