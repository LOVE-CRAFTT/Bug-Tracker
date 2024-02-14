import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/custom_dropdown.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/ui_components/appbar.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/build_bug_page_table_row.dart';

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
      appBar: reusableAppBar("Bugs"),
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
                      page: DropdownPage.bugPage,
                      constraints: constraints,
                    ),
                    Expanded(child: Container()),
                    HeaderButton(
                      screenIsWide: screenIsWide,
                      buttonText: "Submit Bug",
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
                              bugName: "Hexagons don't fold",
                              projectName: "Origami Algorithm",
                              reporter: "alanBroker@gmail.com",
                              timeCreated: DateTime(
                                2023,
                                DateTime.december,
                                DateTime.thursday,
                              ),
                              assignee: "chukwuemekachukwudi9@gmail.com",
                              tags: [Tags.performance, Tags.functionality],
                              dueDate: DateTime(
                                2024,
                                DateTime.january,
                                DateTime.tuesday,
                              ),
                              status: Status.open,
                            ),
                            buildTableRow(
                              bugName: "Font doesn't change",
                              projectName: "Android studio",
                              reporter: "lanceArmstrong@gmail.com",
                              timeCreated: DateTime(
                                2022,
                                DateTime.june,
                                DateTime.sunday,
                              ),
                              assignee: "chukwuemekachukwudi9@gmail.com",
                              tags: [Tags.functionality, Tags.ui],
                              dueDate: DateTime(
                                2022,
                                DateTime.june,
                                DateTime.thursday,
                              ),
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
      ),
    );
  }
}
