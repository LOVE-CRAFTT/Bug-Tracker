import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/staff_appbar.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/work_session.dart';
import 'package:bug_tracker/utilities/work_session_functions.dart';
import 'package:bug_tracker/ui_components/empty_screen_placeholder.dart';
import 'package:bug_tracker/ui_components/custom_circular_progress_indicator.dart';

class SessionsLog extends StatelessWidget {
  const SessionsLog({super.key, required this.taskID});
  final int taskID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: staffReusableAppBar("Sessions Log", context),
      body: FutureBuilder(
        future: retrieveAllWorkSessions(taskID: taskID),
        builder:
            (BuildContext context, AsyncSnapshot<List<WorkSession>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CustomCircularProgressIndicator());
          } else {
            return Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  buildHeader(),
                  Expanded(
                    child: snapshot.data!.isNotEmpty
                        ? ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Center(
                                child: LogRow(
                                  session: snapshot.data![index],
                                  index: index + 1,
                                ),
                              );
                            },
                          )
                        : const Center(child: EmptyScreenPlaceholder()),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class LogRow extends StatelessWidget {
  const LogRow({
    super.key,
    required this.session,
    required this.index,
  });
  final WorkSession session;
  final int index;

  @override
  Widget build(BuildContext context) {
    TextStyle logEntriesTextStyle = kContainerTextStyle.copyWith(
      fontSize: 13,
      color: Colors.white,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              index.toString(),
              style: logEntriesTextStyle,
            ),
            Text(
              convertToDateStringSessionsLog(session.startDate),
              style: logEntriesTextStyle,
            ),
            Text(
              session.endDate != null
                  ? convertToDateStringSessionsLog(session.endDate!)
                  : "On going",
              style: session.endDate != null
                  ? logEntriesTextStyle
                  : logEntriesTextStyle.copyWith(color: Colors.green),
            ),
            Text(
              session.endDate != null
                  ? getTimeDifference(
                      session.endDate!,
                      session.startDate,
                      fromSessionsLog: true,
                    )
                  : "On going",
              style: session.endDate != null
                  ? logEntriesTextStyle
                  : logEntriesTextStyle.copyWith(color: Colors.green),
            ),
          ],
        ),
        const Divider(
          color: Colors.grey,
        )
      ],
    );
  }
}

Column buildHeader() {
  TextStyle customStyle = kContainerTextStyle.copyWith(color: Colors.white70);

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("INDEX", style: customStyle),
          Text("START DATE", style: customStyle),
          Text("END DATE", style: customStyle),
          Text("TIME TAKEN", style: customStyle),
        ],
      ),
      const Divider(
        color: Colors.grey,
      )
    ],
  );
}
