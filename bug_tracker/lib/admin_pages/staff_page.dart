import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/staff.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/admin_appbar.dart';
import 'package:bug_tracker/ui_components/staff_overview_card.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/utilities/load_staff_source.dart';
import 'package:bug_tracker/models/staff_updates.dart';
import 'package:bug_tracker/ui_components/empty_screen_placeholder.dart';
import 'package:bug_tracker/ui_components/custom_circular_progress_indicator.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({super.key});

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  String searchBarString = "";

  // for managing retrieved staff length
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
    // watch in case the staff details are updated or
    // staff is deleted
    context.watch<StaffUpdates>();
    return Scaffold(
      appBar: adminReusableAppBar("Staff", context),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var screenIsWide = constraints.maxWidth > 400;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                /// Search Bar
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 200.0,
                    top: 10.0,
                    bottom: 20.0,
                  ),
                  child: SearchBar(
                    leading: const Icon(Icons.search),
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    ),
                    constraints: BoxConstraints(
                      maxHeight: 56.0,

                      /// The width is 40% of the screen is the screen is "wide"
                      /// Else it takes up 65%
                      maxWidth: screenIsWide
                          ? constraints.maxWidth * 0.4
                          : constraints.maxWidth * 0.65,
                    ),
                    hintText: "Search Staff",
                    hintStyle: const MaterialStatePropertyAll<TextStyle>(
                      kContainerTextStyle,
                    ),
                    textStyle: MaterialStatePropertyAll<TextStyle>(
                      kContainerTextStyle.copyWith(color: Colors.white),
                    ),
                    onChanged: (input) {
                      searchBarString = input;
                      setState(() {});
                    },
                  ),
                ),

                /// List of staff
                Container(
                  width: determineContainerDimensionFromConstraint(
                    constraintValue: constraints.maxWidth,
                    subtractValue: 0,
                  ),
                  height: determineContainerDimensionFromConstraint(
                    constraintValue: constraints.maxHeight,
                    subtractValue: 106,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1e1e1e),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: FutureBuilder(
                    future: loadStaffSource(limit),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CustomCircularProgressIndicator(),
                        );
                      } else {
                        List<Staff> localStaffSource = filterStaffSource(
                          searchBarString: searchBarString,
                        );

                        return filterStaffSource(
                          searchBarString: searchBarString,
                        ).isNotEmpty
                            ? ListView.builder(
                                controller: scrollController,
                                itemCount: localStaffSource.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return StaffOverviewCard(
                                    staff: localStaffSource[index],
                                  );
                                },
                              )
                            : const EmptyScreenPlaceholder();
                      }
                    },
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

List<Staff> filterStaffSource({required String searchBarString}) {
  // will contain the final filtered list
  List<Staff> filteredList = [];

  // helper function to get full name
  String getFullName(Staff staff) {
    return getFullNameFromNames(
      surname: staff.surname,
      firstName: staff.firstName,
      middleName: staff.middleName,
    );
  }

  // if string is empty return staffSource
  if (searchBarString.trim().isEmpty) return staffSource;

  // filter first by ID, then name then email
  filteredList = staffSource
      .where(
        (staff) =>
            staff.id.toString().contains(searchBarString) ||
            getFullName(staff).toUpperCase().contains(
                  searchBarString.toUpperCase(),
                ) ||
            staff.email.toUpperCase().contains(
                  searchBarString.toUpperCase(),
                ),
      )
      .toList();

  return filteredList;
}
