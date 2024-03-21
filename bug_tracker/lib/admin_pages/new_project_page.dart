import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/admin_pages/new_staff_page.dart';

///Text editing Controllers
TextEditingController projectTitleController = TextEditingController();
TextEditingController projectDetailsController = TextEditingController();

/// Separated this way so set-state can be accessed
class NewProjectPage extends StatefulWidget {
  const NewProjectPage({
    super.key,
  });

  @override
  State<NewProjectPage> createState() => _NewProjectPageState();
}

class _NewProjectPageState extends State<NewProjectPage> {
  String projectTitle = "";
  String projectDetails = "";

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
                      decoration: textFormFieldDecoration("Project Title"),
                      style: kContainerTextStyle.copyWith(color: Colors.white),
                      controller: projectTitleController,
                      validator: (lProjectTitle) {
                        if (lProjectTitle == null || lProjectTitle.isEmpty) {
                          return "Project title can't be empty";
                        }
                        projectTitle = lProjectTitle;
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
                          if (lProjectDetails == null ||
                              lProjectDetails.isEmpty) {
                            lProjectDetails = "";
                          }
                          projectDetails = lProjectDetails;
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
                    Navigator.pop(context);
                    projectTitleController.clear();
                    projectDetailsController.clear();
                    buildConfirmationPopup(
                      context,
                      newProjectID: 1234567,
                      newStaffID: null,
                    );
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
