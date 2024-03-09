import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/admin_appbar.dart';
import 'package:bug_tracker/ui_components/custom_dropdown.dart';
import 'package:bug_tracker/ui_components/bug_reports.dart';
import 'package:bug_tracker/ui_components/activities.dart';

/// This page contains a dropdown button for switching between projects
/// A text field to start conversations and pages containing the feed, and activity stream
/// The feed page in contrast to the discussion page is for starting general conversations
class AdminFeedPage extends StatefulWidget {
  const AdminFeedPage({super.key});

  @override
  State<AdminFeedPage> createState() => _AdminFeedPageState();
}

class _AdminFeedPageState extends State<AdminFeedPage> {
  String? dropDownValue = feedChoices.first;
  final _spacingHeight = 50.0;
  final _numberOfPages = 2;
  final _pageHeight = 600.0;
  final _leftPadding = 75.0;
  _rightPadding(constraints) => constraints.maxWidth > 600 ? 150.0 : 50.0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _numberOfPages,
      child: Scaffold(
        appBar: adminReusableAppBar("Feed", context),
        body: ListView(
          children: [
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomDropDown(
                      dropDownValue: dropDownValue,
                      onChanged: (selected) {
                        setState(() {
                          dropDownValue = selected;
                        });
                      },
                      constraints: constraints,
                      page: DropdownPage.feedPage,
                    ),
                    SizedBox(
                      height: _spacingHeight,
                    ),
                    // DiscussionTextField(
                    //   constraints: constraints,
                    //   userInitials: "BC",
                    // ),
                    // SizedBox(
                    //   height: _spacingHeight,
                    // ),
                    TabBar(
                      tabs: const [
                        Text("Bug Reports", style: kContainerTextStyle),
                        Text("Activity Stream", style: kContainerTextStyle),
                      ],
                      indicatorColor: secondaryThemeColor,
                      padding: EdgeInsets.only(
                        left: _leftPadding,
                        right: _rightPadding(constraints),
                      ),
                    ),
                    SizedBox(
                      height: _pageHeight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: _leftPadding,
                          right: _rightPadding(constraints),
                          top: _spacingHeight,
                        ),
                        child: const TabBarView(
                          children: [
                            BugReports(),
                            Activities(),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
