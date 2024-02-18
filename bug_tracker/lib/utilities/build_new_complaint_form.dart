import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:bug_tracker/utilities/constants.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    return "Bug Title can't be empty";
                  }
                  bugTitle = title;
                  return null;
                },
              ),
            ),

            /// Notes accompanying the bug title
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 20.0,
                ),
                child: TextFormField(
                  decoration: complaintTextFieldStyle(hintText: "Notes"),
                  style: kContainerTextStyle.copyWith(color: Colors.white),
                  controller: notesController,
                  maxLines: null,
                  expands: true,
                  validator: (notes) {
                    if (notes == null || notes.isEmpty) {
                      return "Notes can't be empty";
                    }
                    userNotes = notes;
                    return null;
                  },
                ),
              ),
            ),
            Tooltip(
              message: "Add files",
              textStyle: kContainerTextStyle.copyWith(
                fontSize: 12.0,
                color: Colors.black87,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.attach_file_sharp,
                ),
              ),
            ),

            /// Submit button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    /// Here I add the data to the database
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Complaint added',
                          style: kContainerTextStyle.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: secondaryThemeColor,
                  textStyle: kContainerTextStyle,
                ),
                child: const Text("Submit"),
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
