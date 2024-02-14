import 'package:flutter/material.dart';
import 'package:bug_tracker/main_screen.dart';
import 'package:bug_tracker/utilities/constants.dart';

String? userName;
String? password;
Widget? mainScreen;

Map<String, String> users = {
  'admin': 'adminPassword',
  'user': 'userPassword',
  'staff': 'staffPassword',
};

void getMainScreen() {
  if (userName == 'admin') {
    mainScreen = const AdminMainScreen();
  } else if (userName == 'user') {
    mainScreen = const AdminMainScreen();
  } else {
    mainScreen = const AdminMainScreen();
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
                  decoration: const InputDecoration(labelText: 'Username'),
                  style: kContainerTextStyle.copyWith(
                    color: const Color(0xFF979c99),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    userName = value;
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
                      if (users[userName] == password) {
                        ///Get entry point for either user, admin or staff
                        getMainScreen();
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
                              'Invalid username or password',
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
