import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/custom_navigation_rail.dart';
import 'package:bug_tracker/pages/home_page.dart';

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
  void choosePage() {
    switch (selectedIndex) {
      case 0:
        page = const HomePage();
      case 1:
        page = const Placeholder();
      default:
        page = const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
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
