import 'package:flutter/material.dart';
import 'package:bug_tracker/database/db.dart';

// updates when email or name is changed
// and when staff is deleted
class StaffUpdates extends ChangeNotifier {
  Future<void> updateStaffEmail({
    required staffID,
    required String newEmail,
  }) async {
    // attempt to update email
    bool success = await db.updateStaffEmail(
      staffID: staffID,
      newEmail: newEmail,
    );

    // if successful
    if (success == true) {
      notifyListeners();
    }
    // else
    else {
      debugPrint('Failed to update email');
    }
  }

  Future<void> updateStaffName({
    required int staffID,
    required String surname,
    required String? firstName,
    required String? middleName,
  }) async {
    // attempt to update name
    bool success = await db.updateStaffName(
      staffID: staffID,
      surname: surname,
      firstName: firstName,
      middleName: middleName,
    );

    // if successful
    if (success == true) {
      notifyListeners();
    }
    // else
    else {
      debugPrint('Failed to update email');
    }
  }

  Future<void> deleteStaff({required int staffID}) async {}
}
