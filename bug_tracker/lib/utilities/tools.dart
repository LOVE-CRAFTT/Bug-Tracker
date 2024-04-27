import 'package:intl/intl.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

///
double normalize0to1(double value) {
  value = value.clamp(0, 100);
  return value /= 100;
}

///
double getPercentage({required int number, required int total}) {
  return ((number / total) * 100).ceilToDouble();
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
String convertToDateStringSessionsLog(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
}

///
String getTimeDifference(DateTime newer, DateTime older,
    {required bool fromSessionsLog}) {
  Duration difference = newer.difference(older);

  int months = (difference.inDays / 30).floor();
  int days = (difference.inDays % 30).floor();
  int hours = (difference.inHours % 24).floor();
  int minutes = (difference.inMinutes % 60).floor();

  //increased resolution if viewing from sessions log
  int? seconds;
  if (fromSessionsLog) seconds = (difference.inSeconds % 60).floor();

  List<String> timeUnits = [];

  if (months != 0) {
    timeUnits.add('${months}M');
  }
  if (days != 0) {
    timeUnits.add('${days}d');
  }
  if (hours != 0) {
    timeUnits.add('${hours}h');
  }
  if (minutes != 0) {
    timeUnits.add('${minutes}m');
  }
  if (seconds != null && seconds != 0 && fromSessionsLog) {
    timeUnits.add('${seconds}s');
  }

  if (timeUnits.join(' ').isEmpty && !fromSessionsLog) {
    return '0m';
  } else if (timeUnits.join(' ').isEmpty && fromSessionsLog) {
    return '0s';
  } else {
    return timeUnits.join(' ');
  }
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
