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
  return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
}
