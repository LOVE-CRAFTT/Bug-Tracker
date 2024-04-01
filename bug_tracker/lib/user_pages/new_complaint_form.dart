import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/select_files.dart';
import 'package:bug_tracker/ui_components/file_preview_card.dart';
import 'package:bug_tracker/database/db.dart';

class NewComplaintForm extends StatefulWidget {
  const NewComplaintForm({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  State<NewComplaintForm> createState() => _NewComplaintFormState();
}

class _NewComplaintFormState extends State<NewComplaintForm> {
  late int projectID;
  late String bugTitle;

  /// Nullable in case the user doesn't input any notes
  String? userNotes;

  /// controllers
  TextEditingController projectIdController = TextEditingController();
  TextEditingController bugTitleController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  /// List of chosen files
  List<File>? selectedFiles;

  /// To dynamically increase size of space allotted to file preview
  double filePreviewSize = 0;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: widget.constraints.maxHeight - 100,
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
                        style:
                            kContainerTextStyle.copyWith(color: Colors.white),
                        controller: notesController,
                        maxLines: null,
                        expands: true,
                        validator: (notes) {
                          ///Notes can be empty
                          userNotes = notes?.isEmpty == true ? null : notes;
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Tooltip(
              message: "Add files",
              textStyle: kContainerTextStyle.copyWith(
                fontSize: 12.0,
                color: Colors.black87,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.attach_file_sharp,
                  ),
                  onPressed: () async {
                    List<File>? newFiles = await selectFiles();

                    // implemented this way ts space for each can keep up
                    if (newFiles != null) {
                      if (selectedFiles == null) {
                        selectedFiles = newFiles;
                      } else {
                        selectedFiles!.addAll(newFiles);
                      }
                    }

                    // reset file preview sizes
                    filePreviewSize = 0;

                    // add space to display each file below add file icon
                    if (selectedFiles != null) {
                      for (var _ in selectedFiles!) {
                        filePreviewSize += 60;
                      }
                    }
                    setState(() {});
                  },
                ),
              ),
            ),

            /// selected files if any
            if (selectedFiles != null)
              SizedBox(
                height: filePreviewSize,
                child: ListView.builder(
                  itemCount: selectedFiles!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FilePreviewCard(
                      file: selectedFiles![index],
                      onDelete: () {
                        // since the index is "this"
                        selectedFiles!.removeAt(index);
                        filePreviewSize -= 60;

                        // self explanatory
                        if (selectedFiles!.isEmpty) {
                          filePreviewSize = 0;
                          selectedFiles = null;
                        }
                        setState(() {});
                      },
                      isSelectingFiles: true,
                    );
                  },
                ),
              ),

            /// Submit button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    /// connect to database
                    /// ensure project exists else no project error
                    /// then add complaint
                    /// if successful then add complaint files to table
                    /// if successful disconnect from database

                    if (context.mounted) {
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
                    }
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
    );
  }
}
