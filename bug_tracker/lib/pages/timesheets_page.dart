import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/appbar.dart';

class TimesheetsPage extends StatefulWidget {
  const TimesheetsPage({super.key});

  @override
  State<TimesheetsPage> createState() => _TimesheetsPageState();
}

class _TimesheetsPageState extends State<TimesheetsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar("Feed"),
      body: const Center(
        child: Text("Timesheets contents"),
      ),
    );
  }
}
