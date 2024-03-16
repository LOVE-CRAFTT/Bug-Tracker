import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:intl/intl.dart';

class Activities extends StatelessWidget {
  const Activities({super.key});

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
              activity.task ?? activity.discussion ?? "",
            ),
            subtitleTextStyle: kContainerTextStyle.copyWith(fontSize: 18.0),
            trailing: Text(
              DateFormat('yyyy-MM-dd HH:mm').format(activity.timeOfAction),
              style: kContainerTextStyle.copyWith(fontSize: 10.0),
            ),
            //TODO: Maybe go to corresponding activity page
            // onTap: () {},
          ),
        );
      },
    );
  }
}

// Action represents the different actions a user can take in the app.
enum Action {
  opened(associatedText: "opened"),
  closed(associatedText: "closed"),
  started(associatedText: "started"),
  added(associatedText: "added"),
  removed(associatedText: "removed"),
  finished(associatedText: "finished"),
  deleted(associatedText: "deleted");

  const Action({required this.associatedText});
  final String associatedText;
}

// Item represents the different items a user can interact with in the app.
enum Item {
  task(associatedText: "Task"),
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
    this.discussion,
    this.task,
    required this.timeOfAction,
  });

  final String actor;
  final String actorInitials;
  final Action action;
  final Item item;
  final String? discussion;
  final String? task;
  final DateTime timeOfAction;
}

List<Activity> activitySource = [
  Activity(
    actor: "Kenny McCormack",
    actorInitials: "KM",
    action: Action.started,
    item: Item.task,
    task: "Re release",
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
