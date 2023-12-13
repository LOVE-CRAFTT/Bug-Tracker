import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

// Variables for displaying the nav bar or not, and current selected in the nav bar
//Moved out for access in main_screen
bool showAppBar = false;
int selectedIndex = 5;

///Contains a static [SizedBox] and an Expanded scrollable NavigationRail arranged in a column,
///This arrangement is to imitate an appbar at the top
class CustomNavigationRail extends StatelessWidget {
  const CustomNavigationRail(
      {super.key, this.onPressed, this.onDestinationSelected});

  final void Function()? onPressed;
  final void Function(int)? onDestinationSelected;

  //Default width for extended navRail and height for appbar
  //gotten from docs
  static const navRailWidth = 220.0;
  static const appBarHeight = 56.0;

  @override
  Widget build(BuildContext context) {
    double currentScreenWidth = MediaQuery.sizeOf(context).width;
    if (currentScreenWidth < bigScreenWidth) {
      showAppBar = false;
    }

    return Column(
      children: [
        SizedBox(
          height: appBarHeight,
          width: showAppBar ? navRailWidth : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(showAppBar ? Icons.menu_open : Icons.menu),
                onPressed: onPressed,
              ),
              if (showAppBar) ...[
                const Text(
                  'Bug Tracker',
                  style: kAppBarTextStyle,
                ),
              ],
            ],
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      extended: showAppBar,
                      destinations: kMainNavigationRailDestinations,
                      selectedIndex: selectedIndex,
                      onDestinationSelected: onDestinationSelected,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
