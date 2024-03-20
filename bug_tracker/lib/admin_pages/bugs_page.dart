import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/custom_dropdown.dart';
import 'package:bug_tracker/ui_components/admin_appbar.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/build_bug_page_table_row.dart';
import 'package:bug_tracker/ui_components/complaint_overview_card.dart';

///Contains interface to all the bugs in the database
class BugsPage extends StatefulWidget {
  const BugsPage({super.key});

  @override
  State<BugsPage> createState() => _BugsPageState();
}

class _BugsPageState extends State<BugsPage> {
  String? dropDownValue = bugChoices.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminReusableAppBar("Bugs", context),
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
                  page: DropdownPage.bugPage,
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
                              assignee: "chukwuemekachukwudi9@gmail.com",
                              percentCompleted: normalize0to1(40),
                              complaint: complaintsSource[0],
                            ),
                            buildTableRow(
                              context: context,
                              assignee: "chukwuemekachukwudi9@gmail.com",
                              percentCompleted: normalize0to1(11),
                              complaint: complaintsSource[1],
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
