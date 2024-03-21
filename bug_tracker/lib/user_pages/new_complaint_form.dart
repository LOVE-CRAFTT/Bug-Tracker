import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bug_tracker/utilities/constants.dart';

late int projectID;
late String bugTitle;

/// Nullable in case the user doesn't input any notes
String userNotes = "";

final TextEditingController projectIdController = TextEditingController();
final TextEditingController bugTitleController = TextEditingController();
final TextEditingController notesController = TextEditingController();

class NewComplaintForm extends StatelessWidget {
  const NewComplaintForm({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Form(
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
                  decoration: textFormFieldDecoration('Project ID'),
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
                  decoration: textFormFieldDecoration("Bug Title"),
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
                    decoration: textFormFieldDecoration("Notes"),
                    style: kContainerTextStyle.copyWith(color: Colors.white),
                    controller: notesController,
                    maxLines: null,
                    expands: true,
                    validator: (notes) {
                      ///Notes can be empty
                      userNotes = notes ?? "";
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
                  onPressed: () {
                    ///TODO: file_picker package
                  },
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
                      Navigator.pop(context);
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
                      projectIdController.clear();
                      bugTitleController.clear();
                      notesController.clear();
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
}
