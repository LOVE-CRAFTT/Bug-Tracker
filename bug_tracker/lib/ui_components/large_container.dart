import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/bug_preview_lite.dart';
import 'package:bug_tracker/ui_components/task_preview_lite.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/utilities/load_complaint_source.dart';

///Provides access to main work data
///Implemented as a container of fixed height and variable width
///Each container contains an appbar and Expanded body,
///Icons in the appbar adds functionality and the body contains the main data
class LargeContainer extends StatefulWidget {
  const LargeContainer({super.key, required this.type});
  final LargeContainerTypes type;

  @override
  State<LargeContainer> createState() => _LargeContainerState();
}

class _LargeContainerState extends State<LargeContainer> {
  //===============VALUES FROM TESTING==========================================
  var bigScreenMaxWidthLimit = 850;
  var containerHeight = 400.0;
  //============================================================================

  // scroll controllers for listview widgets
  // to maintain position when retrieving data sources of new length
  ScrollController bugsListController = ScrollController();
  ScrollController tasksListController = ScrollController();

  // limit for queries
  int limit = 10;

  // On init state load the complaint and task sources
  // then attach listeners in order to retrieve again with increased range
  // when actor has scrolled to the end
  @override
  void initState() {
    super.initState();
    bugsListController.addListener(() {
      // if its at end but not the top then its at the end
      if (bugsListController.position.atEdge) {
        if (bugsListController.position.pixels != 0) {
          limit += 5;
          setState(() {});
        }
      }
    });
  }

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
                    widget.type.title,
                    style: kAppBarTextStyle,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: (widget.type == LargeContainerTypes.allBugs)
                        ? getBugsList(context)
                        : getTasksList(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ListView getTasksList(BuildContext context) {
    return ListView.builder(
      controller: tasksListController,
      itemCount: tasksSource.length,
      itemBuilder: (BuildContext context, int index) {
        return TaskPreviewLite(
          task: tasksSource[index],
        );
      },
    );
  }

  FutureBuilder<void> getBugsList(BuildContext context) {
    return FutureBuilder(
      future: loadComplaintSource(limit: limit),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return ListView.builder(
            controller: bugsListController,
            itemCount: complaintsSource.length,
            itemBuilder: (BuildContext context, int index) {
              return BugPreviewLite(complaint: complaintsSource[index]);
            },
          );
        }
      },
    );
  }
}

enum LargeContainerTypes {
  myTasks(title: "My Tasks"),
  tasksDueToday(title: "My Tasks Due Today"),
  overdueTasks(title: "My Overdue Tasks"),
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
