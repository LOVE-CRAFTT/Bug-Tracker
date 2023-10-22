import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/appbar.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar("Projects"),
      body: const Center(
        child: Text("Projects contents"),
      ),
    );
  }
}
