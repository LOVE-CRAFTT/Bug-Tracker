import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/staff_appbar.dart';

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
      appBar: staffReusableAppBar("Tasks"),
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Text(
                staffName,
                style: kContainerTextStyle,
              ),
            ),
            Expanded(
              child: Text(
                staffName,
                style: kContainerTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
