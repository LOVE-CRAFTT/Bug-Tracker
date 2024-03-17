import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/header_button.dart';

///Text editing Controllers
TextEditingController surnameController = TextEditingController();
TextEditingController middleNameController = TextEditingController();
TextEditingController firstNameController = TextEditingController();
TextEditingController staffEmailController = TextEditingController();

///value of isAdmin
bool isAdmin = false;

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
  String middleName = "";
  String firstName = "";
  String email = "";

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
                    decoration: newStaffOrProjectFormTextFieldStyle(
                        hintText: 'Surname'),
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
                    decoration: newStaffOrProjectFormTextFieldStyle(
                        hintText: 'Middle Name'),
                    style: kContainerTextStyle.copyWith(color: Colors.white),
                    controller: middleNameController,
                    validator: (lMiddleName) {
                      if (lMiddleName == null || lMiddleName.isEmpty) {
                        lMiddleName = "";
                      }
                      middleName = lMiddleName;
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: newStaffOrProjectFormTextFieldStyle(
                        hintText: 'First Name'),
                    style: kContainerTextStyle.copyWith(color: Colors.white),
                    controller: firstNameController,
                    validator: (lFirstName) {
                      if (lFirstName == null || lFirstName.isEmpty) {
                        lFirstName = "";
                      }
                      firstName = lFirstName;
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration:
                        newStaffOrProjectFormTextFieldStyle(hintText: 'E-mail'),
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
                    Navigator.pop(context);
                    surnameController.clear();
                    middleNameController.clear();
                    firstNameController.clear();
                    staffEmailController.clear();
                    buildConfirmationPopup(
                      context,
                      newProjectID: null,
                      newStaffID: 1234567,
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

InputDecoration newStaffOrProjectFormTextFieldStyle(
    {required String hintText}) {
  return InputDecoration(
    border: const OutlineInputBorder(),
    hintText: hintText,
    hintStyle: kContainerTextStyle,
    isCollapsed: false,
    errorStyle: kContainerTextStyle.copyWith(
      color: Colors.red,
      fontSize: 15,
    ),
  );
}

Future buildConfirmationPopup(BuildContext context,
    {required int? newStaffID, required int? newProjectID}) {
  int id;
  if (newStaffID != null) {
    id = newStaffID;
  } else {
    id = newProjectID!;
  }

  ///
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
          'New ${newStaffID != null ? "staff" : "project"} added successfully'),
      titleTextStyle: kContainerTextStyle.copyWith(
        color: Colors.white,
        fontSize: 20.0,
      ),
      content: Text('New ${newStaffID != null ? "staff" : "project"} ID: $id,\n'
          '${newStaffID != null ? "default password 000000 i.e 6 zeros" : ""} '),
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
