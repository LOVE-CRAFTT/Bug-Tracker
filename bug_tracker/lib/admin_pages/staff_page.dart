import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/admin_appbar.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({super.key});

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminReusableAppBar("Staff", context),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(),
          );
        },
      ),
    );
  }
}
