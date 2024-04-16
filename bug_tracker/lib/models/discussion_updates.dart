import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/staff.dart';
import 'package:bug_tracker/database/db.dart';

class DiscussionUpdates extends ChangeNotifier {
  Future<void> startDiscussion({
    required String topic,
    required List<Staff> participants,
  }) async {
    bool success = await db.addDiscussion(
      title: topic,
      participants: participants,
    );

    if (success) {
      notifyListeners();
    } else {
      debugPrint("error starting conversation");
    }
  }
}
