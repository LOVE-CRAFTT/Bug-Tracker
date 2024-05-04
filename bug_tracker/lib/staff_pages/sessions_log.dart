import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:bug_tracker/ui_components/staff_appbar.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/work_session.dart';
import 'package:bug_tracker/utilities/work_session_functions.dart';
import 'package:bug_tracker/ui_components/empty_screen_placeholder.dart';
import 'package:bug_tracker/ui_components/custom_circular_progress_indicator.dart';

class SessionsLog extends StatefulWidget {
  const SessionsLog({super.key, required this.taskID});
  final int taskID;

  @override
  State<SessionsLog> createState() => _SessionsLogState();
}

class _SessionsLogState extends State<SessionsLog> {
  LogView logView = LogView.raw;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: staffReusableAppBar("Sessions Log", context),
      body: FutureBuilder(
        future: retrieveAllWorkSessions(taskID: widget.taskID),
        builder:
            (BuildContext context, AsyncSnapshot<List<WorkSession>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CustomCircularProgressIndicator());
          } else {
            List<WorkSession> workSessions = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: HeaderButton(
                        screenIsWide: true,
                        buttonText: "Switch View",
                        onPress: () {
                          // switch view based on current view
                          if (logView == LogView.raw) {
                            logView = LogView.stylized;
                          } else {
                            logView = LogView.raw;
                          }
                          setState(() {});
                        },
                      ),
                    ),
                  ),

                  // show table and total if in raw mode
                  if (logView == LogView.raw) ...[
                    buildHeader(),
                    Expanded(
                      child: workSessions.isNotEmpty
                          ? ListView.builder(
                              itemCount: workSessions.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Center(
                                  child: LogRow(
                                    session: workSessions[index],
                                    index: index + 1,
                                  ),
                                );
                              },
                            )
                          : const Center(child: EmptyScreenPlaceholder()),
                    ),
                    TotalCompletedWorkSessionTime(workSessions: workSessions),
                  ],

                  // show timeline and total if in stylized mode
                  if (logView == LogView.stylized) ...[
                    Expanded(
                      child: workSessions.isNotEmpty
                          ? TimeLine(workSessions: workSessions)
                          : const Center(child: EmptyScreenPlaceholder()),
                    ),
                  ],
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class TimeLine extends StatelessWidget {
  const TimeLine({
    super.key,
    required this.workSessions,
  });

  final List<WorkSession> workSessions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Timeline.tileBuilder(
            builder: TimelineTileBuilder.connectedFromStyle(
              itemCount: workSessions.length,
              contentsBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workSessions[index].endDate != null
                          ? "End date: ${convertToDateStringSessionsLog(workSessions[index].endDate!)}"
                          : "On going",
                      style: workSessions[index].endDate != null
                          ? kContainerTextStyle.copyWith(
                              fontSize: 14,
                              color: Colors.white,
                            )
                          : kContainerTextStyle.copyWith(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                    ),
                    InnerTimeLine(workSession: workSessions[index])
                  ],
                ),
              ),
              indicatorStyleBuilder: (context, index) =>
                  workSessions[index].endDate != null
                      ? IndicatorStyle.dot
                      : IndicatorStyle.outlined,
              connectorStyleBuilder: (context, index) =>
                  ConnectorStyle.solidLine,
              firstConnectorStyle: ConnectorStyle.transparent,
            ),
            theme: TimelineThemeData(
              nodePosition: 0,
              indicatorPosition: 0.25,
              color: secondaryThemeColorBlue,
              indicatorTheme: const IndicatorThemeData(
                color: secondaryThemeColor,
                size: 20,
              ),
              connectorTheme: const ConnectorThemeData(),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TotalCompletedWorkSessionTime(workSessions: workSessions),
          ),
        ),
      ],
    );
  }
}

class InnerTimeLine extends StatelessWidget {
  const InnerTimeLine({
    super.key,
    required this.workSession,
  });

  final WorkSession workSession;

  @override
  Widget build(BuildContext context) {
    return FixedTimeline.tileBuilder(
      builder: TimelineTileBuilder.connectedFromStyle(
        itemCount: 1,
        contentsBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Start date: ${convertToDateStringSessionsLog(workSession.startDate)}",
                style: kContainerTextStyle.copyWith(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              Text(
                workSession.endDate != null
                    ? "Time Spent: ${getTimeDifference(
                        workSession.endDate!,
                        workSession.startDate,
                        fromSessionsLog: true,
                      )}"
                    : "On going",
                style: workSession.endDate != null
                    ? kContainerTextStyle.copyWith(
                        fontSize: 13,
                        color: Colors.grey,
                      )
                    : kContainerTextStyle.copyWith(
                        fontSize: 13,
                        color: Colors.green,
                      ),
              ),
            ],
          ),
        ),
        indicatorStyleBuilder: (context, index) => IndicatorStyle.outlined,
        connectorStyleBuilder: (context, index) => ConnectorStyle.solidLine,
      ),
      theme: TimelineThemeData(
        nodePosition: 0,
        color: Colors.grey,
        indicatorTheme: const IndicatorThemeData(
          color: Colors.grey,
        ),
        connectorTheme: const ConnectorThemeData(),
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

class TotalCompletedWorkSessionTime extends StatelessWidget {
  const TotalCompletedWorkSessionTime({super.key, required this.workSessions});

  final List<WorkSession> workSessions;

  @override
  Widget build(BuildContext context) {
    List<WorkSession> completedSessions = workSessions
        .where(
          (session) => session.endDate != null,
        )
        .toList();

    String getTotal() {
      Duration total = const Duration();

      // get total duration
      for (WorkSession session in completedSessions) {
        total += session.endDate!.difference(session.startDate);
      }

      // return a good representation
      int months = (total.inDays / 30).floor();
      int days = (total.inDays % 30).floor();
      int hours = (total.inHours % 24).floor();
      int minutes = (total.inMinutes % 60).floor();
      int seconds = (total.inSeconds % 60).floor();

      List<String> timeUnits = [];

      if (months != 0) {
        timeUnits.add('${months}M');
      }
      if (days != 0) {
        timeUnits.add('${days}d');
      }
      if (hours != 0) {
        timeUnits.add('${hours}h');
      }
      if (minutes != 0) {
        timeUnits.add('${minutes}m');
      }
      if (seconds != 0) {
        timeUnits.add('${seconds}s');
      }

      if (timeUnits.join(' ').isEmpty) {
        return '0s';
      } else {
        return timeUnits.join(' ');
      }
    }

    return Text(
      "Total Completed Work Sessions: ${getTotal()}",
      style: kContainerTextStyle.copyWith(
        color: Colors.white,
        fontSize: 25,
      ),
    );
  }
}

// all possible views
enum LogView { raw, stylized }
