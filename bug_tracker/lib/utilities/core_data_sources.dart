import 'package:bug_tracker/utilities/task.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/utilities/project.dart';
import 'package:bug_tracker/utilities/staff.dart';

/// Main complaint source.
List<Complaint> complaintsSource = [
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
    tags: [],
  ),
  Complaint(
    ticketNumber: 11209465,
    complaint: "Can't sign in using phone number",
    complaintNotes: null,
    complaintState: ComplaintState.pending,
    associatedProject: projectSource[6],
    dateCreated: DateTime(2023, 6, 17),
    author: "person3@gmail.com",
    tags: [],
  ),
  Complaint(
    ticketNumber: 87453092,
    complaint: "App crashes after 3 tabs are open",
    complaintNotes: complaintNotesPlaceholder,
    complaintState: ComplaintState.inProgress,
    associatedProject: projectSource[0],
    dateCreated: DateTime(2020, 2, 13),
    author: "person@gmail.com",
    tags: null,
  ),
  Complaint(
    ticketNumber: 450089791,
    author: "Bob Schmidt@yahoo.com",
    complaint: "Constant crashing on windows 7",
    complaintNotes: null,
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
    complaintNotes: complaintNotesPlaceholder,
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

/// Main task source
List<Task> tasksSource = [
  Task(
    id: 299386366281,
    associatedComplaint: complaintsSource[0],
    task: "Run Youtube main branch in sandbox to replicate issue",
    taskState: TaskState.fresh,
    dueDate: DateTime(2024, 2, 13),
    assignedStaff: staffSource[0],
    isTeamLead: true,
  ),
  Task(
    id: 299386366281,
    associatedComplaint: complaintsSource[1],
    task: "Ascertain from user files if user is premium user",
    taskState: TaskState.inProgress,
    dueDate: DateTime(2023, 2, 13),
    assignedStaff: staffSource[1],
    isTeamLead: false,
  ),
  Task(
    id: 299386366281,
    associatedComplaint: complaintsSource[1],
    task: "Replicate issue in main branch",
    taskState: TaskState.dueToday,
    dueDate: DateTime(2024, 3, 4),
    assignedStaff: staffSource[2],
    isTeamLead: false,
  ),
  Task(
    id: 299386366281,
    associatedComplaint: complaintsSource[2],
    task: "Figure out which other types of phone numbers don't work",
    taskState: TaskState.completed,
    dueDate: DateTime(2024, 2, 13),
    assignedStaff: staffSource[3],
    isTeamLead: false,
  ),
  Task(
    id: 299386366281,
    associatedComplaint: complaintsSource[4],
    task: "Try to obtain the device specifications from user files",
    taskState: TaskState.overdue,
    dueDate: DateTime(2024, 1, 1),
    assignedStaff: staffSource[0],
    isTeamLead: false,
  ),
];

/// Main Project source
List<Project> projectSource = [
  Project(
    id: 1552634899504,
    name: "Android Studio",
    details: projectDetailsPlaceHolder,
    state: ProjectState.closed,
    dateCreated: DateTime(
      2023,
      DateTime.december,
      DateTime.thursday,
    ),
    dateClosed: DateTime(
      2024,
      DateTime.january,
      DateTime.tuesday,
    ),
  ),
  Project(
    id: 1552634899505,
    name: "Flutter App",
    state: ProjectState.open,
    dateCreated: DateTime(
      2023,
      DateTime.november,
      DateTime.monday,
    ),
    dateClosed: DateTime(
      2024,
      DateTime.january,
      DateTime.tuesday,
    ),
    details: projectDetailsPlaceHolder,
  ),
  Project(
    id: 1552634899506,
    name: "Web Development",
    details: "This is a project about web development.",
    state: ProjectState.postponed,
    dateCreated: DateTime(
      2023,
      DateTime.october,
      DateTime.wednesday,
    ),
    dateClosed: DateTime(
      2024,
      DateTime.january,
      DateTime.tuesday,
    ),
  ),
  Project(
    id: 1552634899507,
    name: "Machine Learning",
    details: projectDetailsPlaceHolder,
    state: ProjectState.postponed,
    dateCreated: DateTime(
      2023,
      DateTime.september,
      DateTime.friday,
    ),
    dateClosed: DateTime(
      2024,
      DateTime.january,
      DateTime.tuesday,
    ),
  ),
  Project(
    id: 1552634899508,
    name: "Data Science",
    details: "This is a project about data science.",
    state: ProjectState.cancelled,
    dateCreated: DateTime(
      2023,
      DateTime.august,
      DateTime.saturday,
    ),
    dateClosed: DateTime(
      2024,
      DateTime.february,
      DateTime.sunday,
    ),
  ),
  Project(
    id: 98098790,
    name: "Youtube",
    details: null,
    state: ProjectState.cancelled,
    dateCreated: DateTime(2023, 2, 13),
    dateClosed: DateTime(
      2024,
      DateTime.january,
      DateTime.tuesday,
    ),
  ),
  Project(
    id: 12656564,
    name: "Github Mobile",
    details: projectDetailsPlaceHolder,
    state: ProjectState.postponed,
    dateCreated: DateTime(2022, 12, 3),
    dateClosed: DateTime(
      2024,
      DateTime.january,
      DateTime.tuesday,
    ),
  ),
  Project(
    id: 09653097,
    name: "Whatsapp",
    details: null,
    state: ProjectState.cancelled,
    dateCreated: DateTime(2022, 7, 11),
    dateClosed: DateTime(
      2024,
      DateTime.january,
      DateTime.tuesday,
    ),
  ),
];

// Main staff Source
List<Staff> staffSource = [
  Staff(
    id: 34566728,
    surname: "assigned",
    middleName: "staff",
    firstName: "0",
    email: "assignedStaff@gmail.com",
  ),
  Staff(
    id: 27364746,
    surname: "assigned",
    middleName: "staff",
    firstName: null,
    email: "assignedStaff1@gmail.com",
  ),
  Staff(
    id: 09898762,
    surname: "assigned",
    middleName: "staff",
    firstName: "2",
    email: "assignedStaff2@gmail.com",
  ),
  Staff(
    id: 12341288,
    surname: "assigned",
    middleName: "staff",
    firstName: null,
    email: "assignedStaff3@gmail.com",
  ),
  Staff(
    id: 65654354,
    surname: "assigned",
    middleName: "staff",
    firstName: "4",
    email: "assignedStaff4@gmail.com",
  ),
];
