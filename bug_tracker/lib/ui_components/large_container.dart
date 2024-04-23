import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bug_tracker/ui_components/bug_preview_lite.dart';
import 'package:bug_tracker/ui_components/task_preview_lite.dart';
import 'package:bug_tracker/ui_components/empty_screen_placeholder.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/task.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/utilities/load_complaints_source.dart';
import 'package:bug_tracker/utilities/load_tasks_source.dart';
import 'package:bug_tracker/models/tasks_update.dart';
import 'package:bug_tracker/models/component_state_updates.dart';
import 'package:bug_tracker/ui_components/custom_circular_progress_indicator.dart';

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

  // limit for queries
  int limit = 10;

  // scroll controller for listview widget
  // to maintain position when retrieving data sources of new length
  ScrollController scrollController = ScrollController();

  // on initState attach listeners in order to retrieve again with increased range
  // when actor has scrolled to the end
  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      // if its at end but not the top then its at the end
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          limit += 5;
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // watch TaskStateUpdates for updates to task states
    // and rebuild
    context.watch<TaskStateUpdates>();

    //watch TaskUpdate for updates to tasks and rebuild
    context.watch<TasksUpdate>();
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
                  automaticallyImplyLeading: false,
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

  FutureBuilder getTasksList(BuildContext context) {
    return FutureBuilder(
      future: loadTasksSourceByStaff(staffID: globalActorID, limit: limit),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomCircularProgressIndicator();
        } else {
          // will sort by status and put here
          List<Task> localTaskSource = [];

          if (widget.type == LargeContainerTypes.myTasks) {
            localTaskSource = tasksSource;
          }
          if (widget.type == LargeContainerTypes.overdueTasks) {
            localTaskSource = tasksSource
                .where(
                  (task) => task.taskState == TaskState.overdue,
                )
                .toList();
          }
          if (widget.type == LargeContainerTypes.tasksDueToday) {
            localTaskSource = tasksSource
                .where(
                  (task) => task.taskState == TaskState.dueToday,
                )
                .toList();
          }

          // if there isn't any corresponding task show empty screen placeholder
          return localTaskSource.isNotEmpty
              ? ListView.builder(
                  controller: scrollController,
                  itemCount: localTaskSource.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TaskPreviewLite(
                      task: localTaskSource[index],
                    );
                  },
                )
              : const EmptyScreenPlaceholder();
        }
      },
    );
  }

  FutureBuilder<void> getBugsList(BuildContext context) {
    return FutureBuilder(
      future: loadComplaintsSource(limit: limit),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomCircularProgressIndicator();
        } else {
          // if there aren't corresponding bugs show empty screen placeholder
          return complaintsSource.isNotEmpty
              ? ListView.builder(
                  controller: scrollController,
                  itemCount: complaintsSource.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BugPreviewLite(complaint: complaintsSource[index]);
                  },
                )
              : const EmptyScreenPlaceholder();
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
