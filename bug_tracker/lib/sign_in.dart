import 'package:mysql1/mysql1.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/admin_pages/admin_main_page.dart';
import 'package:bug_tracker/user_pages/sign_up_page.dart';
import 'package:bug_tracker/user_pages/complaint_page.dart';
import 'package:bug_tracker/staff_pages/staff_main_page.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/database/db.dart';

/// SignInPage has been stateful so as to be able to access initState
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with WindowListener {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // listen to the window events
    // added in sign in page because it is the top level stateful widget
    windowManager.addListener(this);
  }

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

                            // get id, name, email and is_admin
                            if (isCorrectPassword) {
                              int actorID = actorData.first['id'];
                              String actorName = getFullNameFromNames(
                                surname: actorData.first['surname'],
                                firstName: actorData.first['first_name'],
                                middleName: actorData.first['middle_name'],
                              );
                              String actorEmail = actorData.first['email'];
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
                              // set global name
                              globalActorName = actorName;
                              // set global email
                              globalActorEmail = actorEmail;
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

                            // get id, name and email and set them globally
                            if (isCorrectPassword) {
                              globalActorID = actorData.first['id'];
                              globalActorName = getFullNameFromNames(
                                surname: actorData.first['surname'],
                                firstName: actorData.first['first_name'],
                                middleName: actorData.first['middle_name'],
                              );
                              globalActorEmail = actorData.first['email'];

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

  // When the window closes then close the database
  @override
  void onWindowClose() async {
    await db.close();
    windowManager.removeListener(this);
    await windowManager.destroy();
  }
}
