import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/staff_appbar.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  String staffName = "Bill Gates";
  String companyName = "Standard Oil Company, Inc.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: staffReusableAppBar("Tasks"),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome, $staffName",
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: "Nunito",
                      color: Color(0xFFb6b8aa),
                    ),
                  ),
                  Text(
                    "Company: $companyName",
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: "Nunito",
                      color: Color(0xFFb6b8aa),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
