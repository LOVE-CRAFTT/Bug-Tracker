import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/custom_navigation_rail.dart';

//================ ADMIN ==========
import 'package:bug_tracker/admin_pages/home_page.dart';
import 'package:bug_tracker/admin_pages/bugs_page.dart';
import 'package:bug_tracker/admin_pages/projects_page.dart';
import 'package:bug_tracker/admin_pages/staff_page.dart';

//=============== STAFF ===========
import 'package:bug_tracker/staff_pages/staff_main_page.dart';
import 'package:bug_tracker/staff_pages/tasks_page.dart';
import 'package:bug_tracker/staff_pages/discuss_page.dart';
import 'package:bug_tracker/staff_pages/calendar_page.dart';

///Process to choose page based on currently selected destination
///Is run everytime new admin destination is selected
Widget selectPageAdmin() {
  switch (selectedIndex) {
    case 0:
      return const HomePage();
    case 1:
      return const DiscussPage();
    case 2:
      return const CalendarPage();
    case 3:
      return const ProjectsPage();
    case 4:
      return const BugsPage();
    case 5:
      return const TasksPage();
    case 6:
      return const StaffPage();
    default:
      return const HomePage();
  }
}

Widget selectPageStaff() {
  switch (selectedIndexStaff) {
    case 0:
      return const TasksPage();
    case 1:
      return const DiscussPage();
    case 2:
      return const CalendarPage();
    default:
      return const TasksPage();
  }
}
