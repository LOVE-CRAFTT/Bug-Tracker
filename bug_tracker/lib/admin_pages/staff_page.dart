import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/admin_appbar.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({super.key});

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminReusableAppBar("Staff", context),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var screenIsWide = constraints.maxWidth > 400;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 500.0,
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: SearchBar(
                    leading: const Icon(Icons.search),
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    ),
                    constraints: BoxConstraints(
                      maxHeight: 56.0,

                      /// The width is 40% of the screen is the screen is "wide"
                      /// Else it takes up 65%
                      maxWidth: screenIsWide
                          ? constraints.maxWidth * 0.4
                          : constraints.maxWidth * 0.65,
                    ),
                    hintText: "Search Staff",
                    hintStyle: const MaterialStatePropertyAll<TextStyle>(
                      kContainerTextStyle,
                    ),
                    textStyle: MaterialStatePropertyAll<TextStyle>(
                      kContainerTextStyle.copyWith(color: Colors.white),
                    ),
                    onSubmitted: (target) {},
                    onChanged: (input) {},
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
