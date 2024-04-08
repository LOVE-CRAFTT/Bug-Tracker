import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

LinearPercentIndicator percentIndicator(double percent) {
  return LinearPercentIndicator(
    percent: percent,
    center: Text(
      "${percent * 100} %",
      style: kContainerTextStyle.copyWith(
        color: Colors.black,
        fontSize: 12.0,
      ),
    ),
    lineHeight: 14.0,
    barRadius: const Radius.circular(5.0),
    backgroundColor: Colors.grey,
    progressColor: secondaryThemeColor,
  );
}
