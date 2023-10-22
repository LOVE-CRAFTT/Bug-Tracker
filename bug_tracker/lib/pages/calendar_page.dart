import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/appbar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar("Calendar"),
      body: const Center(
        child: Text("Calendar contents"),
      ),
    );
  }
}
