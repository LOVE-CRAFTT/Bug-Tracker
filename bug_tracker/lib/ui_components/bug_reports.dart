import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bug_tracker/utilities/constants.dart';

class BugReports extends StatelessWidget {
  const BugReports({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: customerReportSource.length,
      itemBuilder: (BuildContext context, int index) {
        var bugReport = customerReportSource[index];
        return Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: secondaryThemeColor,
            ),
          ),
          child: ListTile(
            leading: Tooltip(
              message: bugReport.reporterName,
              textStyle: kContainerTextStyle.copyWith(
                fontSize: 13.0,
                color: Colors.black,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text(bugReport.reporterInitials),
              ),
            ),
            title: Text("Bug: ${bugReport.bugReport}"),
            titleTextStyle: kContainerTextStyle,
            subtitle: Text("Project:  ${bugReport.project}"),
            subtitleTextStyle: kContainerTextStyle.copyWith(fontSize: 12.0),
            trailing: Text(
              DateFormat('yyyy-MM-dd HH:mm').format(bugReport.timeReported),
              style: kContainerTextStyle.copyWith(fontSize: 12.0),
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}

class CustomerReport {
  CustomerReport({
    required this.reporterName,
    required this.reporterInitials,
    required this.bugReport,
    required this.project,
    required this.timeReported,
  });

  final String reporterName;
  final String reporterInitials;
  final String bugReport;
  final String project;
  final DateTime timeReported;
}

List<CustomerReport> customerReportSource = [
  CustomerReport(
    reporterName: "Bob Schmidt",
    reporterInitials: "BS",
    bugReport: "Constant crashing on windows 7",
    project: "Android Studio",
    timeReported: DateTime(
      2023,
      DateTime.august,
      DateTime.monday,
    ),
  ),
  CustomerReport(
    reporterName: "Steve Cohen",
    reporterInitials: "SC",
    bugReport: "Loud sound before app opens",
    project: "Origami Algorithm",
    timeReported: DateTime(
      2023,
      DateTime.january,
      DateTime.saturday,
    ),
  ),
];
