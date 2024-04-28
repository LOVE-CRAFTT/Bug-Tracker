import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bug_tracker/ui_components/custom_dropdown.dart';
import 'package:bug_tracker/ui_components/admin_appbar.dart';
import 'package:bug_tracker/models/component_state_updates.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/utilities/build_bug_page_table_row.dart';
import 'package:bug_tracker/utilities/load_complaints_source.dart';
import 'package:bug_tracker/ui_components/empty_screen_placeholder.dart';
import 'package:bug_tracker/ui_components/custom_circular_progress_indicator.dart';

///Contains interface to all the bugs in the database
class BugsPage extends StatefulWidget {
  const BugsPage({super.key});

  @override
  State<BugsPage> createState() => _BugsPageState();
}

class _BugsPageState extends State<BugsPage> {
  String dropDownValue = bugChoices.first;

  @override
  Widget build(BuildContext context) {
    // watch ComplaintStateUpdates for updates to complaint state
    // and rebuild
    context.watch<ComplaintStateUpdates>();

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
                FutureBuilder(
                  future: loadComplaintsSource(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CustomCircularProgressIndicator(),
                      );
                    } else {
                      // will contain the filtered complaints
                      List<Complaint> localComplaintsSource =
                          filterComplaintsSource(
                        filter: dropDownValue,
                      );

                      // if the actual value that will be shown i.e the sorted value
                      // is not empty then show them else show the placeholder
                      return (filterComplaintsSource(filter: dropDownValue)
                              .isNotEmpty)
                          ? SizedBox(
                              height: constraints.maxHeight - 100,
                              child: SingleChildScrollView(
                                // to allow to scroll horizontally
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
                                          for (Complaint complaint
                                              in localComplaintsSource)
                                            buildTableRow(
                                              context: context,
                                              complaint: complaint,
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

List<Complaint> filterComplaintsSource({required String filter}) {
  if (filter == 'All Bugs') {
    return complaintsSource;
  } else {
    return complaintsSource
        .where(
          (complaint) => complaint.complaintState.title == filter,
        )
        .toList();
  }
}
