import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/staff_pages/task_page.dart';
import 'package:bug_tracker/ui_components/complaint.dart';
import 'package:bug_tracker/ui_components/task.dart';
import 'package:bug_tracker/utilities/build_complaints.dart';
import 'package:bug_tracker/utilities/build_tasks.dart';

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
                      itemCount: tasksSource.length,
                      itemBuilder: (BuildContext context, int index) {
                        Task dataSource = tasksSource[index];
                        return Column(
                          children: [
                            ListTile(
                              /// task/bug
                              title: Text(dataSource.task),
                              titleTextStyle: kContainerTextStyle.copyWith(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),

                              /// project
                              subtitle: Text(dataSource.complaint.projectName),
                              subtitleTextStyle: kContainerTextStyle.copyWith(
                                fontSize: 12.0,
                              ),

                              /// due date
                              trailing: Text(
                                convertToDateString(dataSource.dueDate),
                                style: kContainerTextStyle.copyWith(
                                  fontSize: 12.0,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TaskPage(
                                      isTeamLead: true,
                                      task: dataSource.task,
                                      complaint: dataSource.complaint,
                                      dueDate: convertToDateString(
                                          dataSource.dueDate),
                                    ),
                                  ),
                                );
                              },
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
  myBugs(title: "My Tasks"),
  workItemsDueToday(title: "My Tasks Due Today"),
  overdueItems(title: "My Overdue Tasks"),
  allBugs(title: "All Bugs");

  const LargeContainerTypes({
    required this.title,
  });
  final String title;
}

///List of largeContainers in the home screen
List<LargeContainer> largeContainers = [
  for (var type in LargeContainerTypes.values)
    LargeContainer(
      type: type,
    )
];
