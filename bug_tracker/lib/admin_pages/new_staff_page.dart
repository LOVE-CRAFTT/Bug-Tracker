import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/database/db.dart';

/// Separated this way so set-state can be accessed
class NewStaffPage extends StatefulWidget {
  const NewStaffPage({
    super.key,
  });

  @override
  State<NewStaffPage> createState() => _NewStaffPageState();
}

class _NewStaffPageState extends State<NewStaffPage> {
  String surname = "";
  String? middleName;
  String? firstName;
  String email = "";

  ///Text editing Controllers
  TextEditingController surnameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController staffEmailController = TextEditingController();

  ///value of isAdmin
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: CheckboxListTile(
              value: isAdmin,
              onChanged: (value) {
                setState(
                  () {
                    isAdmin = value!;
                  },
                );
              },
              title: Text(
                "Mark as admin",
                style: checkboxTextStyle.copyWith(fontSize: 18.0),
              ),
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: textFormFieldDecoration('Surname'),
                    style: kContainerTextStyle.copyWith(color: Colors.white),
                    controller: surnameController,
                    validator: (lSurname) {
                      if (lSurname == null || lSurname.isEmpty) {
                        return "Surname can't be empty";
                      }
                      surname = lSurname;
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: textFormFieldDecoration('First Name'),
                    style: kContainerTextStyle.copyWith(color: Colors.white),
                    controller: firstNameController,
                    validator: (lFirstName) {
                      firstName =
                          lFirstName?.isEmpty == true ? null : lFirstName;
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: textFormFieldDecoration('Middle Name'),
                    style: kContainerTextStyle.copyWith(color: Colors.white),
                    controller: middleNameController,
                    validator: (lMiddleName) {
                      middleName =
                          lMiddleName?.isEmpty == true ? null : lMiddleName;
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: textFormFieldDecoration('E-mail'),
                    style: kContainerTextStyle.copyWith(color: Colors.white),
                    controller: staffEmailController,
                    validator: (lEmail) {
                      if (lEmail == null || lEmail.isEmpty) {
                        return "Email can't be empty";
                      }
                      email = lEmail;
                      return null;
                    },
                  ),
                ),
              ],
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
                    /// add staff and retrieve id for confirmation popup

                    // attempt to add new staff to database
                    int? newStaffID = await db.addNewStaff(
                      isAdmin: isAdmin,
                      email: email,
                      surname: surname,
                      firstName: firstName,
                      middleName: middleName,
                    );
                    // if staff was added successfully
                    if (newStaffID != null) {
                      if (context.mounted) {
                        Navigator.pop(context);
                        surnameController.clear();
                        middleNameController.clear();
                        firstNameController.clear();
                        staffEmailController.clear();
                        await buildConfirmationPopup(
                          context,
                          newProjectID: null,
                          newStaffID: newStaffID,
                        );
                      }
                    }
                    // if staff addition failed
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

Future buildConfirmationPopup(BuildContext context,
    {required int? newStaffID, required int? newProjectID}) async {
  int id;
  if (newStaffID != null) {
    id = newStaffID;
  } else {
    id = newProjectID!;
  }

  ///
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        'New ${newStaffID != null ? "staff" : "project"} added successfully',
      ),
      titleTextStyle: kContainerTextStyle.copyWith(
        color: Colors.white,
        fontSize: 20.0,
      ),
      // project doesn't have password so not necessary to show default password
      content: Text(
        'New ${newStaffID != null ? "staff" : "project"} ID: $id,\n'
        '${newStaffID != null ? "default password 000000 i.e 6 zeros" : ""} ',
      ),
      contentTextStyle: kContainerTextStyle.copyWith(
        color: Colors.white,
        fontSize: 16.0,
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Copy ID',
            style: kContainerTextStyle.copyWith(
                fontSize: 14.0, color: Colors.blue),
          ),
          onPressed: () async {
            /// copy to clipboard then notify
            await Clipboard.setData(ClipboardData(text: id.toString()))
                .then((_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                'Copied to your clipboard !',
                style: kContainerTextStyle.copyWith(color: Colors.black),
              )));
            });
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
        ),
        TextButton(
          child: Text(
            'OK',
            style: kContainerTextStyle.copyWith(
                fontSize: 14.0, color: Colors.blue),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
