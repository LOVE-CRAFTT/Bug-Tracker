import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

class StaffDetailPage extends StatefulWidget {
  const StaffDetailPage({super.key});

  @override
  State<StaffDetailPage> createState() => _StaffDetailPageState();
}

class _StaffDetailPageState extends State<StaffDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericTaskBar("Staff Details"),
      body: const Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
