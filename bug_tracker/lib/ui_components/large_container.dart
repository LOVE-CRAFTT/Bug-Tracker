import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

///Provides access to main work data
///Implemented as a container of fixed height and variable width
///Each container contains an appbar and Expanded body,
///Icons in the appbar adds functionality and the body contains the main data
class LargeContainer extends StatelessWidget {
  final LargeContainerTypes type;

  const LargeContainer({
    Key? key,
    required this.type,
  }) : super(key: key);

  //===============VALUES FROM TESTING==========================================
  static const bigScreenMaxWidthLimit = 850;
  static const containerHeight = 400.0;
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        ///Encompassing Wrap widget spaces them by 10 horizontally
        ///so the width is reduced by 10 so they can fit well
        var containerWidth = constraints.maxWidth <= bigScreenMaxWidthLimit
            ? constraints.maxWidth - 10.0
            : (constraints.maxWidth / 2) - 10.0;

        return DefaultTextStyle(
          style: kContainerTextStyle,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFF1e1e1e),
            ),
            height: containerHeight,
            width: containerWidth,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    type.title,
                    style: kAppBarTextStyle,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: ListView.builder(
                      itemCount: bugSource.length,
                      itemBuilder: (BuildContext context, int index) {
                        var dataSource = bugSource[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(dataSource.title),
                              titleTextStyle: kContainerTextStyle.copyWith(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                              subtitle: Text(dataSource.subtitle),
                              subtitleTextStyle: kContainerTextStyle.copyWith(
                                fontSize: 12.0,
                              ),
                              trailing: Text(
                                dataSource.dateTime.toString(),
                                style: kContainerTextStyle.copyWith(
                                  fontSize: 12.0,
                                ),
                              ),
                              onTap: () {},
                            ),
                            const Divider(
                              color: Color(0xFFb6b8aa),
                              thickness: 0.2,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

enum LargeContainerTypes {
  myBugs(title: "My Bugs"),
  workItemsDueToday(title: "My Work Items Due Today"),
  overdueItems(title: "My Overdue Items"),
  allBugs(title: "All Bugs");

  const LargeContainerTypes({
    required this.title,
  });
  final String title;
}

class Source {
  Source({
    required this.title,
    required this.subtitle,
    required this.dateTime,
  });

  //milestone or bug
  String title;
  //project
  String subtitle;
  DateTime dateTime;
}

List<Source> bugSource = [
  Source(
    title: "Hexagon's don't fold",
    subtitle: "Origami Algorithm",
    dateTime: DateTime(2023, DateTime.december, DateTime.thursday),
  ),
  Source(
    title: "Font doesn't change",
    subtitle: "Android studio",
    dateTime: DateTime(2022, DateTime.june, DateTime.sunday),
  ),
];

List<Source> milestoneSource = [
  Source(
    title: "Release first Version",
    subtitle: "Android Studio",
    dateTime: DateTime(2023, DateTime.december, DateTime.thursday),
  )
];
