import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/appbar.dart';
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
  String name = "John D. Rockefeller";
  String companyName = "Standard Oil Company, Inc.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar("Home"),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 10, top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Welcome $name",
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: "Nunito",
                        color: Color(0xFFb6b8aa),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                      onTapped: () {},
                    ),
                    FastAccessContainer(
                      number: 60,
                      text: "Closed Bugs",
                      icon: Icons.bug_report_outlined,
                      onTapped: () {},
                    ),
                    FastAccessContainer(
                      number: 30,
                      text: "Open Milestones",
                      icon: Icons.stars,
                      onTapped: () {},
                    ),
                    FastAccessContainer(
                      number: 90,
                      text: "Closed Milestones",
                      icon: Icons.stars,
                      onTapped: () {},
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
