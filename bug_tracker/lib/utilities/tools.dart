import 'package:intl/intl.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

///
double normalize0to1(double value) {
  value = value.clamp(0, 100);
  return value /= 100;
}

///
double determineContainerDimensionFromConstraint(
    {required double constraintValue, required int subtractValue}) {
  return constraintValue - subtractValue > 0
      ? constraintValue - subtractValue
      : 0;
}

///
String convertToDateString(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
}

///
String hashPassword(String password) {
  var bytes = utf8.encode(password);
  return sha512.convert(bytes).toString();
}

///
bool authenticatePasswordHash(
    {required String password, required String hashedPassword}) {
  if (hashPassword(password) == hashedPassword) {
    return true;
  } else {
    return false;
  }
}

///
String getFullNameFromNames({
  required String surname,
  required String? firstName,
  required String? middleName,
}) {
  return "$surname ${firstName ?? ""} ${middleName ?? ""}";
}

///
String getInitialsFromName({required String fullName}) {
  return fullName.split(" ").map((name) => name[0].toUpperCase()).join();
}
