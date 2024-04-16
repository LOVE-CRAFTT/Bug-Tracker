import 'package:mysql1/mysql1.dart';
import 'package:bug_tracker/database/db.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/utilities/project.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';

// call specific db function that returns complaints from db newest first
// complaints are processed here and loaded into complaints classes
// classes are then loaded into a list for any further processing
// and put in complaintsSource list
Future<void> loadComplaintsSource({
  required int limit,
}) async {
  List<Complaint> processedComplaints = [];

  // get all the complaints
  Results? results = await db.getAllComplaints(limit: limit);

  // if there are any complaints
  if (results != null) {
    // process them into a complaints class
    for (ResultRow complaintRow in results) {
      // get tags here since can't await in complaint constructor
      var tags = await retrieveTags(complaintID: complaintRow['id']);

      // get associated project here since can't await in complaint constructor
      Results? projectResult =
          await db.getProjectData(complaintRow['associated_project']);
      ResultRow? projectRow = projectResult?.first;

      // get user email here since can't wait in complaints constructor
      Results? authorResults =
          await db.getUserDataUsingID(complaintRow['author']);
      String author = authorResults?.first['email'];

      processedComplaints.add(
        Complaint.fromResultRow(
          complaintRow: complaintRow,
          project: Project.fromResultRow(projectRow: projectRow!),
          author: author,
          tags: tags,
        ),
      );
    }
    complaintsSource = processedComplaints;
  }
  // else no complaints make complaintsSource empty
  else {
    complaintsSource = [];
  }
}

// Helper function to get tags
Future<List<Tags>?> retrieveTags({
  required int complaintID,
}) async {
  Results? results = await db.getTags(complaintID: complaintID);

  // will contain the processed tags
  List<Tags> processedTags = [];

  // if there are tags
  if (results != null) {
    // convert to tags classes
    for (var tagRow in results) {
      processedTags.add(
        Tags.values.firstWhere((tag) => tag.title == tagRow['tag']),
      );
    }
    return processedTags;
  }
  // else return null
  else {
    return null;
  }
}

Future<void> loadComplaintsSourceByUser({
  required int userID,
  required int limit,
}) async {
  List<Complaint> processedComplaints = [];

  // get all the complaints
  Results? results = await db.getComplaintsByUser(userID: userID, limit: limit);

  // if there are any complaints
  if (results != null) {
    // process them into a complaints class
    for (ResultRow complaintRow in results) {
      // get tags here since can't await in complaint constructor
      var tags = await retrieveTags(complaintID: complaintRow['id']);

      // get associated project here since can't await in complaint constructor
      Results? projectResult =
          await db.getProjectData(complaintRow['associated_project']);
      ResultRow? projectRow = projectResult?.first;

      // get user email here since can't wait in complaints constructor
      Results? authorResults =
          await db.getUserDataUsingID(complaintRow['author']);
      String author = authorResults?.first['email'];

      processedComplaints.add(
        Complaint.fromResultRow(
          complaintRow: complaintRow,
          project: Project.fromResultRow(projectRow: projectRow!),
          author: author,
          tags: tags,
        ),
      );
    }
    complaintsSource = processedComplaints;
  }
  // else no complaints make complaintsSource empty
  else {
    complaintsSource = [];
  }
}

Future<void> loadComplaintsSourceByProject({
  required int projectID,
  required int limit,
}) async {
  List<Complaint> processedComplaints = [];

  // get all the complaints
  Results? results = await db.getComplaintsByProject(
    projectID: projectID,
    limit: limit,
  );

  // if there are any complaints
  if (results != null) {
    // process them into a complaints class
    for (ResultRow complaintRow in results) {
      // get tags here since can't await in complaint constructor
      var tags = await retrieveTags(complaintID: complaintRow['id']);

      // get associated project here since can't await in complaint constructor
      Results? projectResult =
          await db.getProjectData(complaintRow['associated_project']);
      ResultRow? projectRow = projectResult?.first;

      // get user email here since can't wait in complaints constructor
      Results? authorResults =
          await db.getUserDataUsingID(complaintRow['author']);
      String author = authorResults?.first['email'];

      processedComplaints.add(
        Complaint.fromResultRow(
          complaintRow: complaintRow,
          project: Project.fromResultRow(projectRow: projectRow!),
          author: author,
          tags: tags,
        ),
      );
    }
    complaintsSource = processedComplaints;
  }
  // else no complaints make complaintsSource empty
  else {
    complaintsSource = [];
  }
}

// work around to retrieve complaint by project
Future<List<Complaint>> retrieveComplaintsByProject({
  required int projectID,
}) async {
  await loadComplaintsSourceByProject(
    projectID: projectID,
    limit: impossiblyLargeNumber,
  );
  return complaintsSource;
}
