import 'package:flutter/material.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage({super.key});

  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  String usersName = "Kamala Harris";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(usersName),
    );
  }
}
