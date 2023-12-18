import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/appbar.dart';
import 'package:bug_tracker/ui_components/custom_dropdown.dart';
import 'package:bug_tracker/ui_components/bug_reports.dart';
import 'package:bug_tracker/ui_components/feed_page_text_field.dart';
import 'package:intl/intl.dart';

/// This page contains a dropdown button for switching between projects
/// A text field to start conversations and pages containing the feed, and activity stream
/// The feed page in contrast to the discussion page is for starting general conversations
class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
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
        appBar: reusableAppBar("Feed"),
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
                    DiscussionTextField(
                      constraints: constraints,
                    ),
                    SizedBox(
                      height: _spacingHeight,
                    ),
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
                            ActivityStream(),
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

class ActivityStream extends StatelessWidget {
  const ActivityStream({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activitySource.length,
      itemBuilder: (BuildContext context, int index) {
        var activity = activitySource[index];
        return Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: secondaryThemeColorGreen,
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Text(activity.actorInitials),
            ),
            // e.g Kenny McCormack opened Milestone
            title: Text(
                "${activity.actor} ${activity.action.associatedText} ${activity.item.associatedText}"),
            titleTextStyle: kContainerTextStyle.copyWith(fontSize: 12.0),
            subtitle: Text(
              activity.milestone ??
                  activity.project ??
                  activity.discussion ??
                  "",
            ),
            subtitleTextStyle: kContainerTextStyle.copyWith(fontSize: 18.0),
            trailing: Text(
              DateFormat('yyyy-MM-dd HH:mm').format(activity.timeOfAction),
              style: kContainerTextStyle.copyWith(fontSize: 10.0),
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}

enum Action {
  opened(associatedText: "opened"),
  closed(associatedText: "closed"),
  started(associatedText: "started"),
  added(associatedText: "added"),
  removed(associatedText: "removed"),
  deleted(associatedText: "deleted");

  const Action({required this.associatedText});
  final String associatedText;
}

enum Item {
  milestone(associatedText: "Milestone"),
  project(associatedText: "Project"),
  discussion(associatedText: "Discussion");

  const Item({required this.associatedText});
  final String associatedText;
}

class Activity {
  Activity({
    required this.actor,
    required this.actorInitials,
    required this.action,
    required this.item,
    this.milestone,
    this.project,
    this.discussion,
    required this.timeOfAction,
  });

  final String actor;
  final String actorInitials;
  final Action action;
  final Item item;
  final String? milestone;
  final String? project;
  final String? discussion;
  final DateTime timeOfAction;
}

List<Activity> activitySource = [
  Activity(
    actor: "Kenny McCormack",
    actorInitials: "KM",
    action: Action.opened,
    item: Item.milestone,
    milestone: "Add consolas font",
    timeOfAction: DateTime(
      2020,
      DateTime.february,
      DateTime.friday,
    ),
  ),
  Activity(
    actor: "Wendy Testaburger",
    actorInitials: "WT",
    action: Action.started,
    item: Item.discussion,
    discussion: "Approach to solving loud sound bug",
    timeOfAction: DateTime(
      2021,
      DateTime.april,
      DateTime.monday,
    ),
  ),
];
