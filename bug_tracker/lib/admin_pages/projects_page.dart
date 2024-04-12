import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/custom_dropdown.dart';
import 'package:bug_tracker/ui_components/admin_appbar.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/utilities/project.dart';
import 'package:bug_tracker/utilities/load_projects_source.dart';
import 'package:bug_tracker/utilities/build_project_page_table_row.dart';
import 'package:bug_tracker/ui_components/empty_screen_placeholder.dart';
import 'package:bug_tracker/ui_components/custom_circular_progress_indicator.dart';

///Contains interface to all the projects in the database
class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  String dropDownValue = projectChoices.first;

  // limit for queries
  int limit = 30;

  // scroll controller for vertical singleChildScrollView widget
  // to maintain position when retrieving data sources of new length
  ScrollController scrollController = ScrollController();

  // add 10 more if reached end of list
  @override
  void initState() {
    scrollController.addListener(
      () {
        if (scrollController.position.atEdge) {
          if (scrollController.position.pixels != 0) {
            limit += 10;
            setState(() {});
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminReusableAppBar("Projects", context),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                CustomDropDown(
                  dropDownValue: dropDownValue,
                  onChanged: (selected) {
                    setState(() {
                      dropDownValue = selected;
                    });
                  },
                  page: DropdownPage.projectPage,
                  constraints: constraints,
                ),
                FutureBuilder(
                  future: loadProjectsSource(limit: limit),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CustomCircularProgressIndicator(),
                      );
                    } else {
                      // filter complaints
                      List<Project> localProjectsSource = filterProjectsSource(
                        filter: dropDownValue,
                      );

                      return (filterProjectsSource(filter: dropDownValue)
                              .isNotEmpty)
                          ? SizedBox(
                              height: constraints.maxHeight - 100,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: DefaultTextStyle(
                                      style: kContainerTextStyle.copyWith(
                                          fontSize: 14.0),
                                      child: Table(
                                        border: const TableBorder(
                                          horizontalInside: BorderSide(
                                            color: Color(0xFF979c99),
                                          ),
                                        ),
                                        defaultColumnWidth:
                                            const FixedColumnWidth(300),
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        children: [
                                          TableRow(
                                            children: [...buildTableHeaders()],
                                          ),
                                          for (Project project
                                              in localProjectsSource)
                                            buildTableRow(
                                              context: context,
                                              project: project,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const EmptyScreenPlaceholder();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

List<Project> filterProjectsSource({required String filter}) {
  if (filter == 'All Projects') {
    return projectsSource;
  } else {
    return projectsSource
        .where(
          (project) => project.state.title == filter,
        )
        .toList();
  }
}
