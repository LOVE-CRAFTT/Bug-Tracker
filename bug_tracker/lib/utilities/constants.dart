import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bug_tracker/ui_components/fast_access_container.dart';
import 'package:bug_tracker/ui_components/large_container.dart';

///Width of a big screen, gotten from testing
///If screen goes lower than this, screen layout changes to accommodate
///[containerHeight] reduces, [FastAccessContainer]s realigns to have 3 maximum on a row
const bigScreenWidth = 712.0;

///TextStyle for the [reusableAppBar]
final kAppBarTextStyle = GoogleFonts.nunito(
  fontSize: 20.0,
  color: const Color(0xFF979c99),
);

///TextStyle for [FastAccessContainer] and [LargeContainer]
final TextStyle kContainerTextStyle = GoogleFonts.nunito(
  fontSize: 16,
  color: const Color(0xFFb6b8aa),
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

///List of largeContainers in the home screen
List<LargeContainer> largeContainers = [
  const LargeContainer(
    title: "My Bugs",
    icons: [Icons.edit, Icons.delete],
    body: Text("Body content goes here"),
  ),
  const LargeContainer(
    title: "My Work Items Due Today",
    icons: [Icons.edit, Icons.delete],
    body: Text("Body content goes here"),
  ),
  const LargeContainer(
    title: "My Overdue Items",
    icons: [Icons.edit, Icons.delete],
    body: Text("Body content goes here"),
  ),
  const LargeContainer(
    title: "My Milestones",
    icons: [Icons.edit, Icons.delete],
    body: Text("Body content goes here"),
  ),
  const LargeContainer(
    title: "My Timesheet",
    icons: [Icons.edit, Icons.delete],
    body: Text("Body content goes here"),
  ),
  const LargeContainer(
    title: "All Bugs",
    icons: [Icons.edit, Icons.delete],
    body: Text("Body content goes here"),
  ),
  const LargeContainer(
    title: "My Events",
    icons: [Icons.edit, Icons.delete],
    body: Text("Body content goes here"),
  ),
];
