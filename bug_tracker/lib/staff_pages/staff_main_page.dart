import 'package:flutter/material.dart';

class StaffMainPage extends StatefulWidget {
  const StaffMainPage({super.key});

  @override
  State<StaffMainPage> createState() => _StaffMainPageState();
}

class _StaffMainPageState extends State<StaffMainPage> {
  String staffName = "Engineer Bill Gates";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(staffName),
    );
  }
}
