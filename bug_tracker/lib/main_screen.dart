import 'package:bug_tracker/models/overview.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/custom_navigation_rail.dart';
import 'package:bug_tracker/utilities/select_page.dart';
import 'package:provider/provider.dart';

///Contains a Static Navigation Rail and changeable pages
class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({Key? key}) : super(key: key);

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
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
