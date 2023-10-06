import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_parts/custom_navigation_rail.dart';
import 'package:bug_tracker/pages/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          CustomNavigationRail(),
          Expanded(
            child: HomePage(),
          )
        ],
      ),
    );
  }
}
