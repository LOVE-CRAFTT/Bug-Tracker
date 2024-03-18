import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/user_pages/complaint_page.dart';
import 'package:bug_tracker/admin_pages/projects_page.dart';

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
                  project: complaint.associatedProject.name,
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
                    "Project: ${complaint.associatedProject.name}",
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
    complaintNotes: complaintNotesPlaceholder,
    complaintState: ComplaintState.completed,
    associatedProject: projectSource[2],
    dateCreated: DateTime(2024, 2, 13),
    author: "person1@gmail.com",
    tags: [Tags.functionality, Tags.ui],
  ),
  Complaint(
    ticketNumber: 76455309,
    complaint: "Discover page doesn't load",
    complaintNotes: complaintNotesPlaceholder,
    complaintState: ComplaintState.acknowledged,
    associatedProject: projectSource[5],
    dateCreated: DateTime(2022, 12, 3),
    author: "person2@gmail.com",
  ),
  Complaint(
    ticketNumber: 11209465,
    complaint: "Can't sign in using phone number",
    complaintNotes: null,
    complaintState: ComplaintState.pending,
    associatedProject: projectSource[6],
    dateCreated: DateTime(2023, 6, 17),
    author: "person3@gmail.com",
  ),
  Complaint(
    ticketNumber: 87453092,
    complaint: "App crashes after 3 tabs are open",
    complaintNotes: complaintNotesPlaceholder,
    complaintState: ComplaintState.inProgress,
    associatedProject: projectSource[0],
    dateCreated: DateTime(2020, 2, 13),
    author: "person@gmail.com",
  ),
  Complaint(
    ticketNumber: 450089791,
    author: "Bob Schmidt@yahoo.com",
    complaint: "Constant crashing on windows 7",
    associatedProject: projectSource[0],
    dateCreated: DateTime(
      2023,
      DateTime.august,
      DateTime.monday,
    ),
    complaintState: ComplaintState.completed,
    tags: [Tags.database],
  ),
  Complaint(
    ticketNumber: 5774883002,
    author: "Steve Cohen@yahoo.com",
    complaint: "Loud sound before app opens",
    associatedProject: projectSource[4],
    dateCreated: DateTime(
      2023,
      DateTime.january,
      DateTime.saturday,
    ),
    complaintState: ComplaintState.acknowledged,
    tags: [Tags.security, Tags.network],
  ),
];
