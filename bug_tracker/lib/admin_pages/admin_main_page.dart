import 'package:bug_tracker/models/overview.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/custom_navigation_rail.dart';
import 'package:bug_tracker/utilities/select_page.dart';
import 'package:provider/provider.dart';

///Contains a Static Navigation Rail and changeable pages
class AdminMainPage extends StatefulWidget {
  const AdminMainPage({Key? key}) : super(key: key);

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  late Widget _page;
  @override
  Widget build(BuildContext context) {
    context.watch<Overview>();
    _page = selectPageAdmin();
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
