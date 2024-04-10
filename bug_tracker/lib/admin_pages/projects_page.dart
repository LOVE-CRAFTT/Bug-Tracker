import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/custom_dropdown.dart';
import 'package:bug_tracker/ui_components/admin_appbar.dart';
import 'package:bug_tracker/utilities/constants.dart';
// import 'package:bug_tracker/utilities/tools.dart';
// import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/utilities/build_project_page_table_row.dart';

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
