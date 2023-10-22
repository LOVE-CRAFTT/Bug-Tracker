import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/custom_navigation_rail.dart';
import 'package:bug_tracker/pages/home_page.dart';
import 'package:bug_tracker/pages/feed_page.dart';
import 'package:bug_tracker/pages/discuss_page.dart';
import 'package:bug_tracker/pages/calendar_page.dart';
import 'package:bug_tracker/pages/projects_page.dart';
import 'package:bug_tracker/pages/bugs_page.dart';
import 'package:bug_tracker/pages/milestones_page.dart';
import 'package:bug_tracker/pages/timesheets_page.dart';

///Contains a Static Navigation Rail and changeable pages
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Widget page;

  ///Process to choose page based on currently selected destination
  ///Is run everytime new destination is selected
  void selectPage() {
    switch (selectedIndex) {
      case 0:
        page = const HomePage();
      case 1:
        page = const FeedPage();
      case 2:
        page = const DiscussPage();
      case 3:
        page = const CalendarPage();
      case 4:
        page = const ProjectsPage();
      case 5:
        page = const BugsPage();
      case 6:
        page = const MilestonesPage();
      case 7:
        page = const TimesheetsPage();
      default:
        page = const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    selectPage();
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomNavigationRail(
            onPressed: () {
              setState(
                () {
                  showAppBar = !showAppBar;
                },
              );
            },
            onDestinationSelected: (int index) {
              setState(
                () {
                  selectedIndex = index;
                },
              );
            },
          ),
          Expanded(
            child: page,
          )
        ],
      ),
    );
  }
}
