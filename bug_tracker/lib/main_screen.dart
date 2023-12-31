import 'package:bug_tracker/models/overview.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/custom_navigation_rail.dart';
import 'package:bug_tracker/utilities/select_page.dart';
import 'package:provider/provider.dart';

///Contains a Static Navigation Rail and changeable pages
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Widget _page;
  @override
  Widget build(BuildContext context) {
    context.watch<Overview>();
    _page = selectPage();
    return Scaffold(
      body: Row(
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
            child: _page,
          )
        ],
      ),
    );
  }
}
