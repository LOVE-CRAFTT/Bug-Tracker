import 'package:bug_tracker/database/db.dart';
import 'package:bug_tracker/utilities/complaint.dart';
import 'package:bug_tracker/utilities/project.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:mysql1/mysql1.dart';

// call specific db function that returns complaints from db newest first
// complaints are processed here and loaded into complaints classes
// classes are then loaded into a list for any further processing
// and put in complaintsSource list
Future<void> loadComplaintSource({
  required int limit,
}) async {
  List<Complaint> processedComplaints = [];

  await db.connect();

  // get all the complaints
  Results? results = await db.getAllComplaints(limit: limit);

  // if there are any complaints
  if (results != null) {
    // process them into a complaints class
    for (ResultRow complaintRow in results) {
      // get tags here since can't await in complaint constructor
      var tags = await retrieveTags(complaintID: complaintRow['id'], db: db);

      // get associated project here since can't await in complaint constructor
      Results? projectResult =
          await db.getProjectData(complaintRow['associated_project']);
      ResultRow? projectRow = projectResult?.first;

      // get user email here since can't wait in complaints constructor
      Results? authorResults =
          await db.getUserDataUsingID(complaintRow['author']);
      String author = authorResults?.first['email'];

      processedComplaints.add(
        // and returns staff and task classes
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

  await db.close();
}

// Helper function to get tags
// Not using the main db class in order not to cause interference with existing connection
// since this is mainly called in the load complaints source function
Future<List<Tags>?> retrieveTags({
  required int complaintID,
  required DB db,
}) async {
  Results? results = await db.getTags(complaintID: complaintID);
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

// GOALS
// Get all Complaints
// Get by user
// Get by project
// NOTE: make get by status be an operation on the already filled complaintsSource
// list in order to reduce query complexity
//
// Get all tasks
// Get by staff
// Get by associated Complaint
// NOTE: make get by status be an operation on the already filled tasksSource
// list in order to reduce query complexity
//
// Get all Projects
// NOTE: make get by status be an operation on the already filled projectsSource
// list in order to reduce query complexity
