import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/appbar.dart';

class MilestonesPage extends StatefulWidget {
  const MilestonesPage({super.key});

  @override
  State<MilestonesPage> createState() => _MilestonesPageState();
}

class _MilestonesPageState extends State<MilestonesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar("Feed"),
      body: const Center(
        child: Text("Milestones contents"),
      ),
    );
  }
}
