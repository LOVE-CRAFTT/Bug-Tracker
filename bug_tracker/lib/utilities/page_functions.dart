import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/custom_navigation_rail.dart';
import 'package:bug_tracker/pages/home_page.dart';
import 'package:bug_tracker/pages/feed_page.dart';
import 'package:bug_tracker/pages/discuss_page.dart';
import 'package:bug_tracker/pages/calendar_page.dart';
import 'package:bug_tracker/pages/bugs_page.dart';
import 'package:bug_tracker/pages/milestones_page.dart';
import 'package:bug_tracker/pages/timesheets_page.dart';

///Process to choose page based on currently selected destination
///Is run everytime new destination is selected
Widget selectPage() {
  switch (selectedIndex) {
    case 0:
      return const HomePage();
    case 1:
      return const FeedPage();
    case 2:
      return const DiscussPage();
    case 3:
      return const CalendarPage();
    // case []:
    //   return const ProjectsPage();
    case 4:
      return const BugsPage();
    case 5:
      return const MilestonesPage();
    case 6:
      return const TimesheetsPage();
    default:
      return const HomePage();
  }
}
