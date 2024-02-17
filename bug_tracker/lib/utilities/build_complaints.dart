import 'package:bug_tracker/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/complaint.dart';

ListView buildComplaints() {
  return ListView.builder(
    itemCount: 6,
    itemBuilder: (BuildContext context, int index) {
      return const Complaint(
        ticketNumber: 34923099,
        complaint: "App doesn't play in background",
        complaintState: ComplaintState.completed,
        projectName: 'Youtube',
      );
    },
  );
}
