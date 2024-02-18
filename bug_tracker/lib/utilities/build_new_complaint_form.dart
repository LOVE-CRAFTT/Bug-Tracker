import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/header_button.dart';

late int projectID;
late String bugTitle;

/// Nullable in case the user doesn't input any notes
String? userNotes;

final TextEditingController projectIdController = TextEditingController();
final TextEditingController bugTitleController = TextEditingController();
final TextEditingController notesController = TextEditingController();

Future buildNewComplaintForm({
  required BuildContext context,
  required BoxConstraints constraints,
}) {
  final formKey = GlobalKey<FormState>();

  return SideSheet.right(
    context: context,
    width: constraints.maxWidth * 0.9,
    sheetColor: lightAshyNavyBlue,
    sheetBorderRadius: 10.0,
    body: Form(
      key: formKey,
      child: SizedBox(
        height: constraints.maxHeight,
        child: Column(
          children: [
            /// Project ID to be gotten from the company
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: complaintTextFieldStyle(hintText: 'Project ID'),
                style: kContainerTextStyle.copyWith(color: Colors.white),
                controller: projectIdController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (id) {
                  if (id == null || id.isEmpty) {
                    return "Project ID can't be empty";
                  }
                  projectID = int.parse(id);
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: complaintTextFieldStyle(hintText: "Bug Title"),
                style: kContainerTextStyle.copyWith(color: Colors.white),
                controller: bugTitleController,
                validator: (title) {
                  if (title == null || title.isEmpty) {
                    return "Project ID can't be empty";
                  }
                  bugTitle = title;
                  return null;
                },
              ),
            ),

            /// Notes accompanying the bug title
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: complaintTextFieldStyle(hintText: "Notes"),
                  style: kContainerTextStyle.copyWith(color: Colors.white),
                  controller: notesController,
                  maxLines: null,
                  expands: true,
                  validator: (notes) {
                    if (notes == null || notes.isEmpty) {
                      return "Project ID can't be empty";
                    }
                    userNotes = notes;
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

InputDecoration complaintTextFieldStyle({required String hintText}) {
  return InputDecoration(
    border: const OutlineInputBorder(),
    hintText: hintText,
    hintStyle: kContainerTextStyle,
    isCollapsed: false,
  );
}
