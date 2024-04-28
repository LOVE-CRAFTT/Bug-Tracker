import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bug_tracker/ui_components/custom_dropdown.dart';
import 'package:bug_tracker/ui_components/admin_appbar.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/utilities/project.dart';
import 'package:bug_tracker/utilities/load_projects_source.dart';
import 'package:bug_tracker/utilities/build_project_page_table_row.dart';
import 'package:bug_tracker/models/component_state_updates.dart';
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

  @override
  Widget build(BuildContext context) {
    // watch ComponentStateUpdates for updates to complaint states
    // and rebuild
    context.watch<ComplaintStateUpdates>();

    // watch ProjectStateUpdates for updates to project states
    // and rebuild
    context.watch<ProjectStateUpdates>();
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
                  future: loadProjectsSource(),
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
