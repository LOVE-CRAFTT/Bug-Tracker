import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

class StaffMainPage extends StatefulWidget {
  const StaffMainPage({super.key});

  @override
  State<StaffMainPage> createState() => _StaffMainPageState();
}

class _StaffMainPageState extends State<StaffMainPage> {
  String staffName = "Engineer Bill Gates";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          staffName,
          style: kContainerTextStyle,
        ),
      ),
    );
  }
}
