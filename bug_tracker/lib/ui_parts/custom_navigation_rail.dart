import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

class CustomNavigationRail extends StatefulWidget {
  const CustomNavigationRail({super.key});

  @override
  State<CustomNavigationRail> createState() => _CustomNavigationRailState();
}

class _CustomNavigationRailState extends State<CustomNavigationRail> {
  bool _showAppBar = true;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(_showAppBar ? Icons.menu_open : Icons.menu),
                onPressed: () {
                  setState(() {
                    _showAppBar = !_showAppBar;
                  });
                },
              ),
              if (_showAppBar) ...[
                // Image.asset('assets/logo.png', width: 36),
                const SizedBox(width: 8),
                const Text('Bug Tracker'),
              ],
            ],
          ),
        ),
        Expanded(
          child: NavigationRail(
            extended: _showAppBar,
            destinations: kMainNavigationRailDestinations,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ],
    );
  }
}
