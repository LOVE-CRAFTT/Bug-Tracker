import 'package:bug_tracker/ui_components/fast_access_container.dart';
import 'package:flutter/material.dart';

///Width of a big screen, gotten from testing
///If screen goes lower than this, screen layout changes to accommodate
///[containerHeight] reduces, [FastAccessContainer]s realigns to have 3 maximum on a row
const bigScreenWidth = 712.0;

///TextStyle for the [reusableAppBar]
const kAppBarTextStyle = TextStyle(
  fontSize: 20.0,
  color: Color(0xFF979c99),
);

Map<String, Icon> navRailData = {
  'Home': const Icon(Icons.home),
  'Feed': const Icon(Icons.feed),
  'Discuss': const Icon(Icons.chat_outlined),
  'Calendar': const Icon(Icons.calendar_month),
  'Projects': const Icon(Icons.work_outline),
  'Bugs': const Icon(Icons.bug_report),
  'Milestones': const Icon(Icons.flag),
  'Timesheets': const Icon(Icons.access_time)
};

List<NavigationRailDestination> kMainNavigationRailDestinations = [
  for (var value in navRailData.entries)
    NavigationRailDestination(
      icon: Tooltip(
        message: value.key,
        child: value.value,
      ),
      label: Text(value.key),
    ),
];
