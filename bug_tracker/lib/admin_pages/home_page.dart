import 'package:bug_tracker/models/overview.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/admin_appbar.dart';
import 'package:provider/provider.dart';
import 'package:bug_tracker/ui_components/fast_access_container.dart';

/// The homepage contains simple welcome text and quick access information
/// By default It contains 4 fast access containers to quickly access general information regarding bugs and milestones
/// It also contains 6 larger containers below that gives more details on the current work context
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String adminName = "John D. Rockefeller";
  String companyName = "Standard Oil Company, Inc.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminReusableAppBar("Home", context),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 10, top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome $adminName",
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
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    FastAccessContainer(
                      number: 10,
                      text: "Open Bugs",
                      icon: Icons.bug_report_outlined,
                      onTapped: () {
                        context.read<Overview>().switchToBug();
                      },
                    ),
                    FastAccessContainer(
                      number: 60,
                      text: "Closed Bugs",
                      icon: Icons.bug_report_outlined,
                      onTapped: () {
                        context.read<Overview>().switchToBug();
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: largeContainers,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
