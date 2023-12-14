import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/custom_dropdown.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/ui_components/appbar.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/build_project_page_table_row.dart';

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
        appBar: reusableAppBar("Projects"),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            var screenIsWide = constraints.maxWidth > 400;
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  Row(
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
                      Expanded(child: Container()),
                      HeaderButton(
                        screenIsWide: screenIsWide,
                        buttonText: "Add Milestone",
                        onPress: () {},
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
                                tags: [Tags.performance, Tags.functionality],
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
