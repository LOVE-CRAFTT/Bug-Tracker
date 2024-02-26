import 'package:bug_tracker/utilities/select_page.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

//
int selectedIndexStaff = 0;

class StaffMainPage extends StatefulWidget {
  const StaffMainPage({super.key});

  @override
  State<StaffMainPage> createState() => _StaffMainPageState();
}

class _StaffMainPageState extends State<StaffMainPage> {
  String staffName = "Bill Gates";
  late Widget _page;

  @override
  Widget build(BuildContext context) {
    _page = selectPageStaff();
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            destinations: staffNavigationRailDestinations,
            selectedIndex: selectedIndexStaff,
            onDestinationSelected: (index) {
              setState(() {
                selectedIndexStaff = index;
              });
            },
          ),
          Expanded(
            child: _page,
          ),
        ],
      ),
    );
  }
}
