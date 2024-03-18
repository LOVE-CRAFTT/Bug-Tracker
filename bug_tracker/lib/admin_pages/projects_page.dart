import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/custom_dropdown.dart';
import 'package:bug_tracker/ui_components/admin_appbar.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/build_project_page_table_row.dart';
import 'package:bug_tracker/utilities/project.dart';

///Contains interface to all the projects in the database
class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  String? dropDownValue = projectChoices.first;

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
                SizedBox(
                  height: constraints.maxHeight - 100,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: DefaultTextStyle(
                        style: kContainerTextStyle.copyWith(fontSize: 14.0),
                        child: Table(
                          border: const TableBorder(
                            horizontalInside: BorderSide(
                              color: Color(0xFF979c99),
                            ),
                          ),
                          defaultColumnWidth: const FixedColumnWidth(300),
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
                              children: [...buildTableHeaders()],
                            ),
                            buildTableRow(
                              context: context,
                              project: projectSource[0],
                              // normalize percentage completed from 0 - 1
                              percentBugsCompleted: normalize0to1(6),
                            ),
                            buildTableRow(
                              context: context,
                              project: projectSource[1],
                              // normalize percentage completed from 0 - 1
                              percentBugsCompleted: normalize0to1(60),
                            ),
                            buildTableRow(
                              context: context,
                              project: projectSource[2],
                              // normalize percentage completed from 0 - 1
                              percentBugsCompleted: normalize0to1(12),
                            ),
                            buildTableRow(
                              context: context,
                              project: projectSource[3],
                              // normalize percentage completed from 0 - 1
                              percentBugsCompleted: normalize0to1(33),
                            ),
                            buildTableRow(
                              context: context,
                              project: projectSource[4],
                              // normalize percentage completed from 0 - 1
                              percentBugsCompleted: normalize0to1(98),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

List<Project> projectSource = [
  Project(
    id: 1552634899504,
    name: "Android Studio",
    details: projectDetailsPlaceHolder,
    state: ProjectState.closed,
    dateCreated: DateTime(
      2023,
      DateTime.december,
      DateTime.thursday,
    ),
    dateClosed: DateTime(
      2024,
      DateTime.january,
      DateTime.tuesday,
    ),
  ),
  Project(
    id: 1552634899505,
    name: "Flutter App",
    state: ProjectState.open,
    dateCreated: DateTime(
      2023,
      DateTime.november,
      DateTime.monday,
    ),
  ),
  Project(
    id: 1552634899506,
    name: "Web Development",
    details: "This is a project about web development.",
    state: ProjectState.postponed,
    dateCreated: DateTime(
      2023,
      DateTime.october,
      DateTime.wednesday,
    ),
  ),
  Project(
    id: 1552634899507,
    name: "Machine Learning",
    state: ProjectState.postponed,
    dateCreated: DateTime(
      2023,
      DateTime.september,
      DateTime.friday,
    ),
  ),
  Project(
    id: 1552634899508,
    name: "Data Science",
    details: "This is a project about data science.",
    state: ProjectState.cancelled,
    dateCreated: DateTime(
      2023,
      DateTime.august,
      DateTime.saturday,
    ),
    dateClosed: DateTime(
      2024,
      DateTime.february,
      DateTime.sunday,
    ),
  ),
  Project(
    id: 98098790,
    name: "Youtube",
    state: ProjectState.cancelled,
    dateCreated: DateTime(2023, 2, 13),
  ),
  Project(
    id: 12656564,
    name: "Github Mobile",
    state: ProjectState.postponed,
    dateCreated: DateTime(2022, 12, 3),
  ),
  Project(
    id: 09653097,
    name: "Whatsapp",
    state: ProjectState.cancelled,
    dateCreated: DateTime(2022, 7, 11),
  ),
];
