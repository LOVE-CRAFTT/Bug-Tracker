import 'package:bug_tracker/ui_components/fast_access_container.dart';
import 'package:flutter/material.dart';

///Width of a big screen, gotten from testing
///If screen goes lower than this, screen layout changes to accommodate
///[] reduces, [FastAccessContainer]s realigns to have 3 maximum on a row
const bigScreenWidth = 712.0;

///TextStyle for the [reusableAppBar]
const kAppBarTextStyle = TextStyle(
  fontSize: 20.0,
  color: Color(0xFF979c99),
);

List<NavigationRailDestination> kMainNavigationRailDestinations = [
  const NavigationRailDestination(
    icon: Icon(Icons.home),
    label: Text('Home'),
  ),
  const NavigationRailDestination(
    icon: Icon(Icons.feed),
    label: Text('Feed'),
  ),
  const NavigationRailDestination(
    icon: Icon(Icons.chat_outlined),
    label: Text('Discuss'),
  ),
  const NavigationRailDestination(
    icon: Icon(Icons.calendar_month),
    label: Text('Calendar'),
  ),
  const NavigationRailDestination(
    icon: Icon(Icons.work_outline),
    label: Text('Projects'),
  ),
  const NavigationRailDestination(
    icon: Icon(Icons.bug_report),
    selectedIcon: Icon(Icons.bug_report),
    label: Text('Bugs'),
  ),
  const NavigationRailDestination(
    icon: Icon(Icons.flag),
    selectedIcon: Icon(Icons.flag),
    label: Text('Milestones'),
  ),
  const NavigationRailDestination(
    icon: Icon(Icons.access_time),
    selectedIcon: Icon(Icons.access_time),
    label: Text('Timesheets'),
  ),
];
