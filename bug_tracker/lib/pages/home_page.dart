import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/appbar.dart';
import 'package:bug_tracker/ui_components/fast_access_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "John Doe";
  String companyName = "Acme Inc.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar,
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
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        color: const Color(0xFFb6b8aa),
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
                      style: GoogleFonts.nunito(
                        fontSize: 15,
                        color: const Color(0xFFb6b8aa),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  spacing: 8.0,
                  children: [
                    FastAccessContainer(
                        number: 10,
                        text: "Open Bugs",
                        icon: Icons.bug_report_outlined),
                    FastAccessContainer(
                        number: 60,
                        text: "Closed Bugs",
                        icon: Icons.bug_report_outlined),
                    FastAccessContainer(
                      number: 30,
                      text: "Open Milestones",
                      icon: Icons.stars,
                    ),
                    FastAccessContainer(
                      number: 90,
                      text: "Closed Milestones",
                      icon: Icons.stars,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
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
