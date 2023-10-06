import 'package:flutter/material.dart';

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
