import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/custom_dropdown.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/utilities/build_complaints.dart';
import 'package:bug_tracker/utilities/build_new_complaint_form.dart';

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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var screenIsWide = constraints.maxWidth > 400;
          return ListView(
            children: [
              Padding(
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
                          page: DropdownPage.userComplaintsPage,
                        ),
                        HeaderButton(
                          screenIsWide: screenIsWide,
                          buttonText: "New Complaint",
                          onPress: () {
                            buildNewComplaintForm(
                              context: context,
                              constraints: constraints,
                            );
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: constraints.maxHeight - 113 > 0
                          ? constraints.maxHeight - 113
                          : 0,
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
              )
            ],
          );
        },
      ),
    );
  }
}
