import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:bug_tracker/ui_components/custom_dropdown.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/ui_components/complaint_overview_card.dart';
import 'package:bug_tracker/user_pages/new_complaint_form.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/utilities/load_complaints_source.dart';
import 'package:bug_tracker/models/component_state_updates.dart';
import 'package:bug_tracker/admin_pages/update_password_page.dart';
import 'package:bug_tracker/ui_components/empty_screen_placeholder.dart';
import 'package:bug_tracker/ui_components/custom_circular_progress_indicator.dart';

/// Page the user sees when logged in.
class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key});

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  String dropDownValue = complaintsChoices.first;
  String searchBarString = "";

  // for managing retrieved complaints length
  ScrollController scrollController = ScrollController();

  // will be increased if scroll to end
  int limit = 30;

  // listens for if user has scrolled to end and generates more
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
    // watch ComplaintStateUpdates for updates to complaint
    // and rebuild
    context.watch<ComplaintStateUpdates>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style: kAppBarTextStyle,
        ),
        backgroundColor: Colors.black,
        actions: [
          MenuAnchor(
            style: MenuStyle(
              backgroundColor: const MaterialStatePropertyAll(
                lightAshyNavyBlue,
              ),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            menuChildren: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: MenuItemButton(
                  style: TextButton.styleFrom(
                    side: const BorderSide(
                      color: secondaryThemeColorBlue,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () {
                    SideSheet.right(
                      context: context,
                      width: MediaQuery.of(context).size.width * 0.3,
                      sheetColor: lightAshyNavyBlue,
                      sheetBorderRadius: 10.0,
                      body: const UpdatePasswordPage(),
                    );
                  },
                  child: const Text(
                    "Update Password",
                    style: kContainerTextStyle,
                  ),
                ),
              )
            ],
            builder: (BuildContext context, MenuController controller,
                Widget? child) {
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: InkWell(
                  onTap: () => controller.isOpen
                      ? controller.close()
                      : controller.open(),
                  child: Tooltip(
                    message: globalActorName,
                    textStyle: kContainerTextStyle.copyWith(
                      color: Colors.black,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Text(
                        getInitialsFromName(fullName: globalActorName),
                        style: kContainerTextStyle.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var screenIsWide = constraints.maxWidth > 400;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 10,
                top: 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Text(
                      "Welcome $globalActorName",
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: "Nunito",
                        color: Color(0xFFb6b8aa),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomDropDown(
                        dropDownValue: dropDownValue,
                        onChanged: (selected) {
                          setState(
                            () {
                              dropDownValue = selected;
                            },
                          );
                        },
                        constraints: constraints,
                        page: DropdownPage.complaintsPage,
                      ),
                      SearchBar(
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
                        textStyle: MaterialStatePropertyAll<TextStyle>(
                          kContainerTextStyle.copyWith(),
                        ),
                        hintText: "Search complaints",
                        hintStyle: MaterialStatePropertyAll<TextStyle>(
                          kContainerTextStyle.copyWith(fontSize: 14.0),
                        ),
                        onChanged: (input) {
                          searchBarString = input;
                          setState(() {});
                        },
                      ),
                      HeaderButton(
                        screenIsWide: screenIsWide,
                        buttonText: "New Complaint",
                        onPress: () {
                          SideSheet.right(
                            context: context,
                            width: constraints.maxWidth * 0.9,
                            sheetColor: lightAshyNavyBlue,
                            sheetBorderRadius: 10.0,
                            body: NewComplaintForm(
                              constraints: constraints,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: determineContainerDimensionFromConstraint(
                      constraintValue: constraints.maxHeight,
                      subtractValue: 113,
                    ),
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      color: const Color(0xFF363739),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: FutureBuilder(
                      future: loadComplaintsSourceByUser(
                        userID: globalActorID,
                        limit: limit,
                      ),
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CustomCircularProgressIndicator(),
                          );
                        } else {
                          List<Complaint> localComplaintsSource =
                              filterComplaintsSource(
                            filter: dropDownValue,
                            searchBarString: searchBarString,
                          );

                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: filterComplaintsSource(
                              filter: dropDownValue,
                              searchBarString: searchBarString,
                            ).isNotEmpty
                                ? ListView.builder(
                                    controller: scrollController,
                                    itemCount: localComplaintsSource.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ComplaintOverviewCard(
                                        complaint: localComplaintsSource[index],
                                      );
                                    },
                                  )
                                : const EmptyScreenPlaceholder(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

List<Complaint> filterComplaintsSource({
  required String filter,
  required String searchBarString,
}) {
  // will contain final filtered list
  List<Complaint> filteredList = [];

  // filter first by dropDownValue
  if (filter == 'All complaints') {
    filteredList = complaintsSource;
  } else {
    filteredList = complaintsSource
        .where(
          (complaint) => complaint.complaintState.title == filter,
        )
        .toList();
  }

  // if there isn't a searchBarString then
  // return the list filtered by dropdown
  // if the string is just whitespace, it should be detected as empty
  if (searchBarString.trim().isEmpty) return filteredList;

  // filter by task containing
  // search bar value
  // to upper case to prevent mismatch in mixed case scenarios
  filteredList = filteredList
      .where(
        (complaint) => complaint.complaint.toUpperCase().contains(
              searchBarString.toUpperCase(),
            ),
      )
      .toList();

  return filteredList;
}
