import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/custom_dropdown.dart';
import 'package:bug_tracker/ui_components/admin_appbar.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/build_project_page_table_row.dart';

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
        appBar: adminReusableAppBar("Projects"),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.filter_alt_outlined),
                          tooltip: "Filter",
                          splashRadius: 20.0,
                        ),
                      )
                    ],
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
                                percentMilestonesCompleted: normalize0to1(60),
                                projectName: "Android studio",
                                percentBugsCompleted: normalize0to1(6),
                                timeCreated: DateTime(
                                  2023,
                                  DateTime.december,
                                  DateTime.thursday,
                                ),
                                timeCompleted: DateTime(
                                  2024,
                                  DateTime.january,
                                  DateTime.tuesday,
                                ),
                                owner: "chukwuemekachukwudi9@gmail.com",
                                status: Status.inProgress,
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
        ));
  }
}
