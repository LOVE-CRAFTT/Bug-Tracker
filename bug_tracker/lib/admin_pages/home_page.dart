import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bug_tracker/models/overview.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/admin_appbar.dart';
import 'package:bug_tracker/ui_components/large_container.dart';
import 'package:bug_tracker/ui_components/fast_access_container.dart';

/// The homepage contains simple welcome text and quick access information
/// By default It contains 2 fast access containers to quickly access general information regarding bugs
/// It also contains 4 larger containers below that gives more details on the current work context
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  "Welcome $globalActorName",
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: "Nunito",
                    color: Color(0xFFb6b8aa),
                  ),
                ),
                const Text(
                  "Company: Meta Platforms, Inc.",
                  style: TextStyle(
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
