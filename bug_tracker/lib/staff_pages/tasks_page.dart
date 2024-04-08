import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bug_tracker/utilities/task.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/ui_components/staff_appbar.dart';
import 'package:bug_tracker/ui_components/custom_dropdown.dart';
import 'package:bug_tracker/ui_components/task_overview_card.dart';
import 'package:bug_tracker/utilities/load_tasks_source.dart';
import 'package:bug_tracker/models/tasks_update.dart';
import 'package:bug_tracker/models/component_state_updates.dart';
import 'package:bug_tracker/ui_components/empty_screen_placeholder.dart';
import 'package:bug_tracker/ui_components/custom_circular_progress_indicator.dart';

/// Page seen when staff log in
class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  String dropDownValue = tasksChoices.first;
  String searchBarString = "";

  // for managing retrieved tasks length
  ScrollController scrollController = ScrollController();

  // will be increased if scroll to end
  int limit = 30;

  // listens for if staff has scrolled to end and generates more
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          limit += 10;
          setState(() {});
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // watch in case the task is removed or just updated
    context.watch<TasksUpdate>();

    // watch to rebuild as the task State progresses
    context.watch<TaskStateUpdates>();

    return Scaffold(
      appBar: staffReusableAppBar("Tasks", context),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var screenIsWide = constraints.maxWidth > 400;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome, $globalActorName",
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: "Nunito",
                      color: Color(0xFFb6b8aa),
                    ),
                  ),
                  const Text(
                    "Company: Meta Platforms, Inc.",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Nunito",
                      color: Color(0xFFb6b8aa),
                    ),
                  ),

                  /// Dropdown value and search tasks
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomDropDown(
                          dropDownValue: dropDownValue,
                          onChanged: (selected) {
                            setState(
                              () {
                                dropDownValue = selected;
                              },
                            );
                          },
                          constraints: constraints,
                          page: DropdownPage.tasksPage,
                        ),
                        SearchBar(
                          leading: const Icon(Icons.search),
                          padding: const MaterialStatePropertyAll<EdgeInsets>(
                            EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                          ),
                          constraints: BoxConstraints(
                            maxHeight: 56.0,

                            /// The width is 40% of the screen is the screen is "wide"
                            /// Else it takes up 65%
                            maxWidth: screenIsWide
                                ? constraints.maxWidth * 0.4
                                : constraints.maxWidth * 0.65,
                          ),
                          textStyle: const MaterialStatePropertyAll<TextStyle>(
                            kContainerTextStyle,
                          ),
                          hintText: "Search tasks",
                          hintStyle: MaterialStatePropertyAll<TextStyle>(
                            kContainerTextStyle.copyWith(fontSize: 14.0),
                          ),
                          onChanged: (input) {
                            searchBarString = input;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                      10.0,
                    ),
                    child: Container(
                      height: constraints.maxHeight - 100 > 0
                          ? constraints.maxHeight - 100
                          : 0,
                      decoration: BoxDecoration(
                        color: lightAshyNavyBlue,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: FutureBuilder(
                        future: loadTasksSourceByStaff(
                            staffID: globalActorID, limit: limit),
                        builder: (BuildContext context,
                            AsyncSnapshot<void> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CustomCircularProgressIndicator(),
                            );
                          } else {
                            List<Task> localTasksSource = filterTasksSource(
                              filter: dropDownValue,
                              searchBarString: searchBarString,
                            );
                            return Padding(
                              padding: const EdgeInsets.all(10.0),

                              // if the actual things to be displayed
                              // which is the filtered taskSource is not empty then
                              // proceed else show the empty screen placeholder
                              child: filterTasksSource(
                                filter: dropDownValue,
                                searchBarString: searchBarString,
                              ).isNotEmpty
                                  ? ListView.builder(
                                      controller: scrollController,
                                      itemCount: localTasksSource.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return TaskOverviewCard(
                                          task: localTasksSource[index],
                                        );
                                      },
                                    )
                                  : const EmptyScreenPlaceholder(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

List<Task> filterTasksSource({
  required String filter,
  required String searchBarString,
}) {
  // will contain final filtered list
  List<Task> filteredList = [];

  // filter first by dropDownValue
  if (filter == 'All tasks') {
    filteredList = tasksSource;
  } else if (filter == 'New (2 days)') {
    filteredList = tasksSource
        .where(
          (task) => task.taskState.title == 'New',
        )
        .toList();
  } else {
    filteredList = tasksSource
        .where(
          (task) => task.taskState.title == filter,
        )
        .toList();
  }

  // if there isn't a searchBarString then
  // return the list filtered by dropdown
  // if the string is just whitespace, it should be detected as empty
  if (searchBarString.trim().isEmpty) return filteredList;

  // filter by task containing
  // search bar value
  // to upper case to prevent mismatch in mixed case scenarios
  filteredList = filteredList
      .where(
        (task) => task.task.toUpperCase().contains(
              searchBarString.toUpperCase(),
            ),
      )
      .toList();

  return filteredList;
}
