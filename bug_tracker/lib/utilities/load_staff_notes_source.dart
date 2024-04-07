import 'package:mysql1/mysql1.dart';
import 'package:bug_tracker/database/db.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';

Future<void> loadStaffNotesSource({required int complaintID}) async {
  List<String> processedNotes = [];

  // get the notes from the database
  Results? results = await db.getStaffNotes(complaintID);

  // if there are any notes
  if (results != null) {
    // process into String
    for (ResultRow noteRow in results) {
      processedNotes.add(noteRow['note'].toString());
    }
    staffNotesSource = processedNotes;
  }
  // else no notes make the notes source an empty list
  else {
    staffNotesSource = [];
  }
}
