import 'package:flutter/material.dart';
import 'package:bug_tracker/database/db.dart';

// updates when new note is sent to user
// only the user should listen for immediate updates
class StaffNotesUpdates extends ChangeNotifier {
  Future<void> addStaffNoteToComplaint({
    required complaintID,
    required String note,
  }) async {
    // attempt to add complaint
    bool success = await db.addStaffNote(complaintID: complaintID, note: note);

    // if successful
    if (success == true) {
      notifyListeners();
    }
    // else
    else {
      debugPrint('Failed to add note');
    }
  }
}
