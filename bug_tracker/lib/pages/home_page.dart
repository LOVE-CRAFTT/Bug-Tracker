import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                        number: 1000,
                        text: "Open Bugs",
                        icon: Icons.bug_report_outlined),
                    FastAccessContainer(
                        number: 6000,
                        text: "Closed Bugs",
                        icon: Icons.bug_report_outlined),
                    FastAccessContainer(
                      number: 3000,
                      text: "Open Milestones",
                      icon: Icons.stars,
                    ),
                    FastAccessContainer(
                      number: 9000,
                      text: "Closed Milestones",
                      icon: Icons.stars,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // Expanded(
                //   child: SingleChildScrollView(
                //     child: Column(
                //       children: const [
                //         LargeContainer(
                //           title: "My Bugs",
                //           icons: [Icons.edit, Icons.delete],
                //           body: Text("Body content goes here"),
                //         ),
                //         LargeContainer(
                //           title: "My Work Items Due Today",
                //           icons: [Icons.edit, Icons.delete],
                //           body: Text("Body content goes here"),
                //         ),
                //         LargeContainer(
                //           title: "My Overdue Items",
                //           icons: [Icons.edit, Icons.delete],
                //           body: Text("Body content goes here"),
                //         ),
                //         LargeContainer(
                //           title: "My Milestones",
                //           icons: [Icons.edit, Icons.delete],
                //           body: Text("Body content goes here"),
                //         ),
                //         LargeContainer(
                //           title: "My Timesheet",
                //           icons: [Icons.edit, Icons.delete],
                //           body: Text("Body content goes here"),
                //         ),
                //         LargeContainer(
                //           title: "All Bugs",
                //           icons: [Icons.edit, Icons.delete],
                //           body: Text("Body content goes here"),
                //         ),
                //         LargeContainer(
                //           title: "My Events",
                //           icons: [Icons.edit, Icons.delete],
                //           body: Text("Body content goes here"),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
