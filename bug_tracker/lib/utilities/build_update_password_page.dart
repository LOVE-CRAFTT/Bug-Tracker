import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/header_button.dart';

Future buildUpdatePasswordPage({
  required BuildContext context,
}) {
  return SideSheet.right(
    context: context,
    width: MediaQuery.of(context).size.width * 0.3,
    sheetColor: lightAshyNavyBlue,
    sheetBorderRadius: 10.0,
    body: const UpdatePasswordPage(),
  );
}

///Text editing Controllers
TextEditingController previousPasswordController = TextEditingController();
TextEditingController newPasswordController = TextEditingController();

/// Separated this way so set-state can be accessed
class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({
    super.key,
  });

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  String previousPassword = "";
  String newPassword = "";

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: updatePasswordFormTextFieldStyle(
                        hintText: 'Previous Password'),
                    style: kContainerTextStyle.copyWith(color: Colors.white),
                    controller: previousPasswordController,
                    validator: (lPreviousPassword) {
                      if (lPreviousPassword == null ||
                          lPreviousPassword.isEmpty) {
                        return "Previous password can't be empty";
                      }
                      previousPassword = lPreviousPassword;
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: updatePasswordFormTextFieldStyle(
                        hintText: 'New Password'),
                    style: kContainerTextStyle.copyWith(color: Colors.white),
                    controller: newPasswordController,
                    validator: (lNewPassword) {
                      if (lNewPassword == null || lNewPassword.isEmpty) {
                        return "New password can't be empty";
                      }
                      newPassword = lNewPassword;
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
                buttonText: "Update",
                onPress: () async {
                  if (formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    previousPasswordController.clear();
                    newPasswordController.clear();

                    /// Add to db here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Password Updated Successfully',
                          style: kContainerTextStyle.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
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

InputDecoration updatePasswordFormTextFieldStyle({required String hintText}) {
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
