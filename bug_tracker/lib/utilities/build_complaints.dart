import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/user_pages/complaint_page.dart';

ListView buildComplaints() {
  return ListView.builder(
    itemCount: complaintsSource.length,
    itemBuilder: (BuildContext context, int index) {
      Complaint complaint = complaintsSource[index];
      return Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ComplaintPage(
                  ticketNumber: complaint.ticketNumber,
                  project: complaint.projectName,
                  complaint: complaint.complaint,
                  complaintState: complaint.complaintState,
                  dateCreated: convertToDateString(complaint.dateCreated),
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: secondaryThemeColor,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "#${complaint.ticketNumber}",
                          style: kContainerTextStyle.copyWith(fontSize: 11),
                        ),
                        Text(
                          "Date Created: ${convertToDateString(complaint.dateCreated)}",
                          style: kContainerTextStyle.copyWith(
                            fontSize: 11.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Complaint: ${complaint.complaint}",
                        style: kContainerTextStyle.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Chip(
                        label: Text(
                          complaint.complaintState.title,
                          style: kContainerTextStyle.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        backgroundColor:
                            complaint.complaintState.associatedColor,
                      ),
                    ],
                  ),
                  Text(
                    "Project: ${complaint.projectName}",
                    style: kContainerTextStyle.copyWith(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

List complaintsSource = [
  Complaint(
      ticketNumber: 34923099,
      complaint: "App doesn't play in background",
      complaintState: ComplaintState.completed,
      projectName: 'Youtube',
      dateCreated: DateTime(2024, 2, 13),
      reporter: "person@gmail.com"),
  Complaint(
      ticketNumber: 76455309,
      complaint: "Discover page doesn't load",
      complaintState: ComplaintState.acknowledged,
      projectName: "Github mobile",
      dateCreated: DateTime(2022, 12, 3),
      reporter: "person@gmail.com"),
  Complaint(
      ticketNumber: 11209465,
      complaint: "Can't sign in using phone number",
      complaintState: ComplaintState.pending,
      projectName: "Whatsapp",
      dateCreated: DateTime(2023, 6, 17),
      reporter: "person@gmail.com"),
  Complaint(
      ticketNumber: 87453092,
      complaint: "App crashes after 3 tabs are open",
      complaintState: ComplaintState.inProgress,
      projectName: "Google Chrome",
      dateCreated: DateTime(2020, 2, 13),
      reporter: "person@gmail.com"),
];
