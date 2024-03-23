import 'package:flutter/material.dart';
import 'package:bug_tracker/admin_pages/admin_main_page.dart';
import 'package:bug_tracker/user_pages/sign_up_page.dart';
import 'package:bug_tracker/user_pages/complaint_page.dart';
import 'package:bug_tracker/staff_pages/staff_main_page.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/header_button.dart';

String? email;
String? password;
Widget? mainScreen;

Map<String, String> users = {
  'admin': 'a',
  'user': 'u',
  'staff': 's',
};

void setMainScreen() {
  if (email == 'admin') {
    mainScreen = const AdminMainPage();
  } else if (email == 'user') {
    mainScreen = const ComplaintPage();
  } else {
    mainScreen = const StaffMainPage();
  }
}

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          if (users[email] == password) {
                            ///Get entry point for either user, admin or staff
                            setMainScreen();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => mainScreen!,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Invalid email or password',
                                  style: kContainerTextStyle.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }
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
