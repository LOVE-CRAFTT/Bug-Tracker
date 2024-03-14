import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/complaint.dart';
import 'package:bug_tracker/utilities/constants.dart';

ListView buildComplaints() {
  return ListView.builder(
    itemCount: complaintsSource.length,
    itemBuilder: (BuildContext context, int index) {
      return complaintsSource[index];
    },
  );
}

List complaintsSource = [
  Complaint(
    ticketNumber: 34923099,
    complaint: "App doesn't play in background",
    complaintStatus: Status.completed,
    projectName: 'Youtube',
    dateCreated: DateTime(2024, 2, 13),
  ),
  Complaint(
    ticketNumber: 76455309,
    complaint: "Discover page doesn't load",
    complaintStatus: Status.acknowledged,
    projectName: "Github mobile",
    dateCreated: DateTime(2022, 12, 3),
  ),
  Complaint(
    ticketNumber: 11209465,
    complaint: "Can't sign in using phone number",
    complaintStatus: Status.pending,
    projectName: "Whatsapp",
    dateCreated: DateTime(2023, 6, 17),
  ),
  Complaint(
    ticketNumber: 87453092,
    complaint: "App crashes after 3 tabs are open",
    complaintStatus: Status.inProgress,
    projectName: "Google Chrome",
    dateCreated: DateTime(2020, 2, 13),
  ),
];
