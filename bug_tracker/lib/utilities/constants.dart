import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/fast_access_container.dart';
import 'package:bug_tracker/ui_components/large_container.dart';
import 'package:table_calendar/table_calendar.dart';

///Width of a big screen, gotten from testing
///If screen goes lower than this, screen layout changes to accommodate
///[containerHeight] reduces, [FastAccessContainer]s realigns to have 3 maximum on a row
const bigScreenWidth = 712.0;

///TextStyle for the [reusableAppBar]
const kAppBarTextStyle = TextStyle(
  fontSize: 20.0,
  fontFamily: "Nunito",
  color: Color(0xFF979c99),
);

///TextStyle for [FastAccessContainer] and [LargeContainer]
const TextStyle kContainerTextStyle = TextStyle(
  fontSize: 16,
  fontFamily: "Nunito",
  color: Color(0xFFb6b8aa),
);

///TextStyle for each cell in the calendar except done/stated otherwise
const TextStyle kCalendarCellTextStyle = TextStyle(
  color: Color(0xFFFAFAFA),
  fontSize: 16.0,
  fontFamily: "Nunito",
);

CalendarStyle kCalendarStyle = CalendarStyle(
  outsideDaysVisible: false,
  defaultTextStyle: kContainerTextStyle,
  todayTextStyle: kCalendarCellTextStyle,
  selectedTextStyle: kCalendarCellTextStyle,
  rangeStartTextStyle: kCalendarCellTextStyle,
  rangeEndTextStyle: kCalendarCellTextStyle,
  weekendTextStyle: kCalendarCellTextStyle,
  markerDecoration: const BoxDecoration(
    color: Color(0xFFFF7F7F),
    shape: BoxShape.circle,
  ),
  todayDecoration: BoxDecoration(
    color: const Color(0xFFFF9B44),
    borderRadius: BorderRadius.circular(11.0),
  ),
  selectedDecoration: BoxDecoration(
    color: secondaryThemeColor,
    borderRadius: BorderRadius.circular(11.0),
  ),
  rangeStartDecoration: const BoxDecoration(
    color: Color(0xFFFF9B44),
    shape: BoxShape.circle,
  ),
  rangeEndDecoration: const BoxDecoration(
    color: Color(0xFFFF9B44),
    shape: BoxShape.circle,
  ),
  rangeHighlightColor: const Color(0xFFFFC05C),
  defaultDecoration: BoxDecoration(
    borderRadius: BorderRadius.circular(11.0),
  ),
  weekendDecoration: BoxDecoration(
    borderRadius: BorderRadius.circular(11.0),
  ),
);

HeaderStyle kCalendarHeaderStyle = const HeaderStyle(
  titleCentered: true,
  titleTextStyle: TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontFamily: "Nunito",
  ),
  formatButtonTextStyle: TextStyle(
    color: Colors.white,
    fontSize: 14.0,
    fontFamily: "Nunito",
  ),
  formatButtonDecoration: BoxDecoration(
    border: Border.fromBorderSide(
      BorderSide(
        color: secondaryThemeColor,
      ),
    ),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
);

DaysOfWeekStyle kCalendarDOWStyle = const DaysOfWeekStyle(
  weekdayStyle: TextStyle(
    fontFamily: "Nunito",
    fontSize: 14.0,
    color: Color(0xFF6E6E6E),
  ),
  weekendStyle: TextStyle(
    fontFamily: "Nunito",
    fontSize: 14.0,
    color: Color(0xFF7F7F7F),
  ),
);

///Used as the secondary theme color to contrast from the grey/black background
const Color secondaryThemeColor = Color(0xFFFF6400);

Map<String, Icon> navRailData = {
  'Home': const Icon(Icons.home),
  'Feed': const Icon(Icons.feed),
  'Discuss': const Icon(Icons.chat_outlined),
  'Calendar': const Icon(Icons.calendar_month),
  // Not for staff will replace when doing the admin
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
        textStyle: kContainerTextStyle.copyWith(
          fontSize: 14.0,
          color: Colors.black,
        ),
        child: value.value,
      ),
      label: Text(
        value.key,
        style: const TextStyle(fontFamily: "Nunito"),
      ),
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
];
