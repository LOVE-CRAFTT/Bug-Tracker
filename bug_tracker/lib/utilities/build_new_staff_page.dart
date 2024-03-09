import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/header_button.dart';

Future buildNewStaffPage({
  required BuildContext context,
}) {
  return SideSheet.right(
    context: context,
    width: MediaQuery.of(context).size.width * 0.7,
    sheetColor: lightAshyNavyBlue,
    sheetBorderRadius: 10.0,
    body: const NewStaffPage(),
  );
}

///Text editing Controllers
TextEditingController surnameController = TextEditingController();
TextEditingController middleNameController = TextEditingController();
TextEditingController firstNameController = TextEditingController();

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
                    decoration: newStaffFormTextFieldStyle(hintText: 'Surname'),
                    style: kContainerTextStyle.copyWith(color: Colors.white),
                    controller: surnameController,
                    validator: (lSurname) {
                      if (lSurname == null || lSurname.isEmpty) {
                        lSurname = "";
                      }
                      surname = lSurname;
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration:
                        newStaffFormTextFieldStyle(hintText: 'Middle Name'),
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
                    decoration:
                        newStaffFormTextFieldStyle(hintText: 'First Name'),
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
              ],
            ),
          ),
          //TODO: Probably figure out adding pictures
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: HeaderButton(
                  screenIsWide: true,
                  buttonText: "Add",
                  onPress: () {
                    formKey.currentState!.validate();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Staff ID Created',
                          style: kContainerTextStyle.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }
}

InputDecoration newStaffFormTextFieldStyle({required String hintText}) {
  return InputDecoration(
    border: const OutlineInputBorder(),
    hintText: hintText,
    hintStyle: kContainerTextStyle,
    isCollapsed: false,
  );
}
