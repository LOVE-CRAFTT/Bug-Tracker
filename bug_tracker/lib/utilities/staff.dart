class Staff {
  Staff({
    required this.id,
    required this.surname,
    required this.middleName,
    required this.firstName,
    required this.email,
  }) : initials = ((firstName != null ? firstName[0] : '') + (surname[0]))
            .toUpperCase();

  final int id;
  final String surname;
  final String? middleName;
  final String? firstName;
  final String initials;
  final String email;
}
