import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:bug_tracker/ui_components/custom_dropdown.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/utilities/build_complaints.dart';
import 'package:bug_tracker/user_pages/new_complaint_form.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';

/// Page the user sees when logged in.
class UserMainPage extends StatefulWidget {
  const UserMainPage({super.key});

  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  String usersName = "Kamala Harris";
  String? dropDownValue = complaintsChoices.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style: kAppBarTextStyle,
        ),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
              onTap: () {},
              child: Tooltip(
                message: usersName,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Text(
                    "KH",
                    style: kContainerTextStyle.copyWith(color: Colors.black),
                  ),
                ),
              ),
            ),
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
                      "Welcome $usersName",
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
                          ///set state here to rebuild complaints
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
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: buildComplaints(),
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
