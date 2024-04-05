import 'package:bug_tracker/utilities/tools.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/database/db.dart';
import 'package:mysql1/mysql1.dart';

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

  ///Text editing Controllers
  TextEditingController previousPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

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
                    decoration: textFormFieldDecoration('Previous Password'),
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
                    decoration: textFormFieldDecoration('New Password'),
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
                    /// connect to database
                    /// get associated password hash of current ID
                    /// hash and compare old password
                    /// if true set new password hash else wrong password
                    /// disconnect from database

                    Results? actorData = actorIsUser
                        ? await db.getUserDataUsingID(globalActorID)
                        : await db.getStaffDataUsingID(globalActorID);

                    // if there wasn't an error in retrieving data
                    // actor has to already be a valid and authenticated actor
                    // since they can access the change password option
                    // reducing potential errors to database call errors
                    if (actorData != null) {
                      // get current password
                      String currentPasswordHash = actorData.first['password'];

                      // check given previous password against current password
                      bool isCorrectPassword = authenticatePasswordHash(
                        password: previousPassword,
                        hashedPassword: currentPasswordHash,
                      );

                      // if given password is correct
                      // attempt to update the password
                      if (isCorrectPassword) {
                        bool success = actorIsUser
                            ? await db.updateUserPassword(
                                id: globalActorID,
                                password: newPassword,
                              )
                            : await db.updateStaffPassword(
                                id: globalActorID,
                                password: newPassword,
                              );

                        // if attempt successful
                        if (success) {
                          if (context.mounted) {
                            Navigator.pop(context);
                            previousPasswordController.clear();
                            newPasswordController.clear();
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
                        }
                        // else password change process failed
                        else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Password change process failed! Try again later',
                                  style: kContainerTextStyle.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }
                        }
                      }
                      // else old password is wrong
                      else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Previous password is wrong',
                                style: kContainerTextStyle.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    }
                    // else process failed
                    else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Process failed! Try again Later',
                              style: kContainerTextStyle.copyWith(
                                color: Colors.black,
                              ),
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
