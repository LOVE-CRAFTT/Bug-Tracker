import 'package:bug_tracker/utilities/constants.dart';
import 'package:flutter/material.dart';

List<String?> feedChoices = [
  "All Projects",
  "Project 1",
  "Project 2",
];
List<String?> milestoneChoices = [
  "All Milestones",
  "Active Milestones",
  "Completed Milestones",
];
List<String?> bugChoices = [
  "All Bugs",
  "All Open",
  "All Closed",
  "My Open",
  "My Closed",
];
List<String?> projectChoices = [
  "All Projects",
  "Active Projects",
  "Completed Projects",
];
List<String?> complaintsChoices = [
  "All complaints",
  "Pending",
  "Acknowledged",
  "In Progress",
  "Completed",
];

///Pages that have a dropdown button
enum DropdownPage {
  feedPage,
  milestonePage,
  bugPage,
  projectPage,
  userComplaintsPage,
}

/// Dropdown button below the appbar on the feed page, bug page and milestone page
/// Implemented as a dropdown button stacked on top of a lighter background for the feed page
/// And just the specialized dropdown for other pages
class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.dropDownValue,
    required this.onChanged,
    required this.constraints,
    required this.page,
  });

  final String? dropDownValue;
  final BoxConstraints constraints;
  final void Function(dynamic)? onChanged;
  final DropdownPage page;

  ///Implemented this way to replace the default border with nothing
  static final Container _noUnderline = Container(
    decoration: const BoxDecoration(border: Border()),
  );

  final _leftPadding = 16.0;
  final _rightPadding = 10.0;
  final _lightBackgroundHeight = 50.0;

  ///Get specific list to build
  List getSource() {
    if (page == DropdownPage.feedPage) {
      return feedChoices;
    } else if (page == DropdownPage.milestonePage) {
      return milestoneChoices;
    } else if (page == DropdownPage.projectPage) {
      return projectChoices;
    } else if (page == DropdownPage.bugPage) {
      return bugChoices;
    } else {
      return complaintsChoices;
    }
  }

  Widget buildButton() => Padding(
        padding: EdgeInsets.only(left: _leftPadding, right: _rightPadding),
        child: DropdownButton(
          value: dropDownValue,
          items: getSource()
              .map(
                (value) => DropdownMenuItem(
                  value: value,
                  child: Text(value!),
                ),
              )
              .toList(),
          onChanged: onChanged,
          underline: _noUnderline,
          focusColor: Colors.transparent,
          style: kContainerTextStyle.copyWith(color: const Color(0xFFFF6400)),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return page == DropdownPage.feedPage
        ? Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white12,
                ),
                width: constraints.maxWidth,
                height: _lightBackgroundHeight,
              ),
              buildButton(),
            ],
          )
        : Align(
            alignment: Alignment.centerLeft,
            child: buildButton(),
          );
  }
}
