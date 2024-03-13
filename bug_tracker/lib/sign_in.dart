import 'package:flutter/material.dart';
import 'package:bug_tracker/admin_pages/admin_main_page.dart';
import 'package:bug_tracker/user_pages/user_main_page.dart';
import 'package:bug_tracker/staff_pages/staff_main_page.dart';
import 'package:bug_tracker/utilities/constants.dart';

String? email;
String? password;
Widget? mainScreen;

Map<String, String> users = {
  'admin': 'adminPassword',
  'user': 'userPassword',
  'staff': 'staffPassword',
};

void setMainScreen() {
  if (email == 'admin') {
    mainScreen = const AdminMainPage();
  } else if (email == 'user') {
    mainScreen = const UserMainPage();
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
      appBar: AppBar(
        title: const Text(
          'Sign In',
          style: kAppBarTextStyle,
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: SizedBox(
          width: 500,
          height: 300,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-mail'),
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
                  decoration: const InputDecoration(labelText: 'Password'),
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
                ElevatedButton(
                  onPressed: () {
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryThemeColor,
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontFamily: "Nunito"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
