import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/custom_navigation_rail.dart';
import 'package:bug_tracker/pages/home_page.dart';
import 'package:bug_tracker/pages/feed_page.dart';
import 'package:bug_tracker/pages/discuss_page.dart';
import 'package:bug_tracker/pages/calendar_page.dart';
import 'package:bug_tracker/pages/bugs_page.dart';
import 'package:bug_tracker/pages/milestones_page.dart';
import 'package:bug_tracker/pages/timesheets_page.dart';
import 'package:bug_tracker/utilities/constants.dart';

///Process to choose page based on currently selected destination
///Is run everytime new destination is selected
Widget selectPage() {
  switch (selectedIndex) {
    case 0:
      return const HomePage();
    case 1:
      return const FeedPage();
    case 2:
      return const DiscussPage();
    case 3:
      return const CalendarPage();
    // case []:
    //   return const ProjectsPage();
    case 4:
      return const BugsPage();
    case 5:
      return const MilestonesPage();
    case 6:
      return const TimesheetsPage();
    default:
      return const HomePage();
  }
}

///Build Table Rows
TableRow buildTableRow({
  String? firstHeader,
  String? secondHeader,
  String? thirdHeader,
  String? conversationTitle,
  String? projectName,
  String? tooltipMessage,
  String? avatarText,
}) {
  TextStyle cellTextStyle = kContainerTextStyle.copyWith(fontSize: 14.0);

  return TableRow(
    children: [
      ListTile(
        leading: firstHeader == null
            ? IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  color: Color(0xFFFF6400),
                  size: 15.0,
                ),
              )
            : null,
        title: Text(firstHeader ?? (conversationTitle ?? "Null Value")),
        titleTextStyle: cellTextStyle,
        onTap: firstHeader == null ? () {} : null,
      ),
      ListTile(
        title: Text(secondHeader ?? (projectName ?? "Null Value")),
        titleTextStyle: cellTextStyle,
        onTap: secondHeader == null ? () {} : null,
      ),
      ListTile(
        title: thirdHeader != null ? Text(thirdHeader) : null,
        titleTextStyle: cellTextStyle,
        leading: thirdHeader != null
            ? null
            : Tooltip(
                message: tooltipMessage,
                child: avatarText != null
                    ? CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Text(avatarText),
                      )
                    : null,
              ),
      )
    ],
  );
}
