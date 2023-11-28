import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/custom_dropdown.dart';
import 'package:bug_tracker/ui_components/appbar.dart';

class BugsPage extends StatefulWidget {
  const BugsPage({super.key});

  @override
  State<BugsPage> createState() => _BugsPageState();
}

class _BugsPageState extends State<BugsPage> {
  String? dropDownValue = bugChoices.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar("Bugs"),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var screenIsWide = constraints.maxWidth > 400;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                Row(
                  children: [
                    CustomDropDown(
                      dropDownValue: dropDownValue,
                      onChanged: (selected) {},
                      page: DropdownPage.bugPage,
                      constraints: constraints,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
