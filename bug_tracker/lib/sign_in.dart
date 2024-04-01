import 'package:flutter/material.dart';
import 'package:bug_tracker/admin_pages/admin_main_page.dart';
import 'package:bug_tracker/user_pages/sign_up_page.dart';
import 'package:bug_tracker/user_pages/complaint_page.dart';
import 'package:bug_tracker/staff_pages/staff_main_page.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/database/db.dart';
import 'package:mysql1/mysql1.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? email;
    String? password;
    Widget? mainScreen;
    return Scaffold(
      appBar: genericTaskBar("Sign In"),
      body: Center(
        child: SizedBox(
          width: 400,
          height: 300,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: textFormFieldDecoration("E-mail").copyWith(
                    border: const UnderlineInputBorder(),
                  ),
                  style: kContainerTextStyle.copyWith(
                    color: const Color(0xFF979c99),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    email = value;
                    return null;
                  },
                ),
                TextFormField(
                  decoration: textFormFieldDecoration("Password").copyWith(
                    border: const UnderlineInputBorder(),
                  ),
                  obscureText: true,
                  style: kContainerTextStyle,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    password = value;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeaderButton(
                      screenIsWide: true,
                      buttonText: "Sign In",
                      onPress: () async {
                        if (_formKey.currentState!.validate()) {
                          /// ensure email exists
                          /// if hashedPassword equals corresponding hashed email password
                          /// then get id and is_admin
                          /// if is_admin admin page receives id

                          await db.connect();
                          Results? actorData;
                          bool? isCorrectPassword;

                          // Is staff
                          if ((actorData =
                                  await db.getStaffDataUsingEmail(email!)) !=
                              null) {
                            //authenticate password
                            isCorrectPassword = authenticatePasswordHash(
                              password: password!,
                              hashedPassword: actorData!.first['password'],
                            );

                            // get id and is_admin
                            if (isCorrectPassword) {
                              int actorID = actorData.first['id'];
                              bool isAdmin = actorData.first['is_admin'] == 1
                                  ? true
                                  : false;

                              if (isAdmin) {
                                // set actor's designation
                                actorIsAdmin = true;
                                actorIsStaff = false;
                                actorIsUser = false;
                                mainScreen = const AdminMainPage();
                              } else {
                                // set actor's designation
                                actorIsAdmin = false;
                                actorIsStaff = true;
                                actorIsUser = false;
                                mainScreen = const StaffMainPage();
                              }
                              // set global id
                              globalActorID = actorID;
                              if (context.mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => mainScreen!,
                                  ),
                                );
                              }
                            } else {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Invalid password',
                                      style: kContainerTextStyle.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }
                          }
                          // check if its user
                          else if ((actorData =
                                  await db.getUserDataUsingEmail(email!)) !=
                              null) {
                            //authenticate password
                            isCorrectPassword = authenticatePasswordHash(
                              password: password!,
                              hashedPassword: actorData!.first['password'],
                            );

                            // get id
                            if (isCorrectPassword) {
                              globalActorID = actorData.first['id'];
                              // set actor's designation
                              actorIsAdmin = false;
                              actorIsStaff = false;
                              actorIsUser = true;
                              if (context.mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ComplaintPage(),
                                  ),
                                );
                              }
                            } else {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Invalid password',
                                      style: kContainerTextStyle.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }
                          } else {
                            // email must be wrong
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Invalid email',
                                    style: kContainerTextStyle.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }
                          }

                          // close connection
                          await db.close();
                        }
                      },
                    ),
                    HeaderButton(
                      screenIsWide: true,
                      buttonText: "Sign Up",
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
