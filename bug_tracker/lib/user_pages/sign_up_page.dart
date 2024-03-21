import 'package:flutter/material.dart';
import 'package:bug_tracker/user_pages/complaint_page.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/header_button.dart';

String? email;
String? password;
String? surname;
String firstName = "";
String middleName = "";

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericTaskBar("Sign Up"),
      body: Center(
        child: SizedBox(
          width: 500,
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
                      if (value == null || value.isEmpty) {
                        value = "";
                      }
                      firstName = value;
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
                      if (value == null || value.isEmpty) {
                        value = "";
                      }
                      middleName = value;
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
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ComplaintPage(),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "New User: $surname created successfully",
                            style: kContainerTextStyle.copyWith(
                                color: Colors.black),
                          ),
                        ),
                      );
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
