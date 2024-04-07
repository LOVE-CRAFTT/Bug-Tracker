import 'package:bug_tracker/utilities/tools.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/user_pages/complaint_page.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/database/db.dart';
import 'package:mysql1/mysql1.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Based on which can and cannot be null
    String email = "";
    String password = "";
    String surname = "";
    String? firstName;
    String? middleName;
    return Scaffold(
      appBar: genericTaskBar("Sign Up"),
      body: Center(
        child: SizedBox(
          width: 400,
          height: 535,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: textFormFieldDecoration("Surname"),
                    style: kContainerTextStyle.copyWith(
                      color: const Color(0xFF979c99),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Surname';
                      }
                      surname = value;
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: textFormFieldDecoration("First Name"),
                    style: kContainerTextStyle.copyWith(
                      color: const Color(0xFF979c99),
                    ),
                    validator: (value) {
                      // if value is null firstName is value
                      // if value isEmpty its null
                      // if value is not empty its value
                      firstName = value?.isEmpty == true ? null : value;
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: textFormFieldDecoration("Middle Name"),
                    style: kContainerTextStyle.copyWith(
                      color: const Color(0xFF979c99),
                    ),
                    validator: (value) {
                      middleName = value?.isEmpty == true ? null : value;
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: textFormFieldDecoration("E-mail"),
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
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: textFormFieldDecoration("Password"),
                    obscureText: false,
                    style: kContainerTextStyle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      password = value;
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                HeaderButton(
                  screenIsWide: true,
                  buttonText: "Sign Up",
                  onPress: () async {
                    if (_formKey.currentState!.validate()) {
                      /// connect to database
                      /// if user i.e email already exists let them know
                      /// put information to database
                      /// set global id
                      /// move to complaint page
                      /// close connection

                      // if actor data is null then user doesn't exist so attempt to create
                      Results? actorData =
                          await db.getUserDataUsingEmail(email);
                      if (actorData == null) {
                        int? newUserID = await db.addNewUser(
                          surname: surname,
                          firstName: firstName,
                          middleName: middleName,
                          email: email,
                          password: password,
                        );
                        // if adding the new user succeeds
                        if (newUserID != null) {
                          // set global id
                          globalActorID = newUserID;
                          // set global name
                          globalActorName = getFullNameFromNames(
                            surname: surname,
                            firstName: firstName,
                            middleName: middleName,
                          );
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "New User: $surname ${firstName ?? ""} ${middleName ?? ""} created successfully",
                                  style: kContainerTextStyle.copyWith(
                                      color: Colors.black),
                                ),
                              ),
                            );
                          }
                        }
                        // if adding fails notify user to try later
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
                      // user already exists notify actor
                      else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "User already exists",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
