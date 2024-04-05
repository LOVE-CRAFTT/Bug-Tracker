import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/admin_pages/new_staff_page.dart';
import 'package:bug_tracker/database/db.dart';

/// Separated this way so set-state can be accessed
class NewProjectPage extends StatefulWidget {
  const NewProjectPage({
    super.key,
  });

  @override
  State<NewProjectPage> createState() => _NewProjectPageState();
}

class _NewProjectPageState extends State<NewProjectPage> {
  String projectName = "";
  String? projectDetails;

  ///Text editing Controllers
  TextEditingController projectNameController = TextEditingController();
  TextEditingController projectDetailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 100,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      decoration: textFormFieldDecoration("Project Name"),
                      style: kContainerTextStyle.copyWith(color: Colors.white),
                      controller: projectNameController,
                      validator: (lProjectName) {
                        if (lProjectName == null || lProjectName.isEmpty) {
                          return "Project name can't be empty";
                        }
                        projectName = lProjectName;
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        decoration: textFormFieldDecoration("Project Details"),
                        expands: true,
                        maxLines: null,
                        style:
                            kContainerTextStyle.copyWith(color: Colors.white),
                        controller: projectDetailsController,
                        validator: (lProjectDetails) {
                          projectDetails = lProjectDetails?.isEmpty == true
                              ? null
                              : lProjectDetails;
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: HeaderButton(
                screenIsWide: true,
                buttonText: "Add",
                onPress: () async {
                  if (formKey.currentState!.validate()) {
                    /// connect to database
                    /// add project retrieve id for confirmation popup
                    /// close connection

                    // attempt to add new project to database returning either the project id or null
                    // if the process is successful
                    int? newProjectID = await db.addNewProject(
                      projectName: projectName,
                      projectDetails: projectDetails,
                    );
                    // if project added successfully
                    if (newProjectID != null) {
                      if (context.mounted) {
                        Navigator.pop(context);
                        projectNameController.clear();
                        projectDetailsController.clear();
                        await buildConfirmationPopup(
                          context,
                          newProjectID: newProjectID,
                          newStaffID: null,
                        );
                      }
                    }
                    // if project addition failed
                    else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Process Failed! Try again later",
                              style: kContainerTextStyle.copyWith(
                                  color: Colors.black),
                            ),
                          ),
                        );
                      }
                    }
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
