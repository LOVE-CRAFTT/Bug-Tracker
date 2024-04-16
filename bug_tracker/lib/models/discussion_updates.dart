import 'package:flutter/material.dart';
import 'package:bug_tracker/database/db.dart';
import 'package:bug_tracker/utilities/staff.dart';

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

class MessageUpdates extends ChangeNotifier {
  Future<void> addMessage({
    required int senderID,
    required int discussionID,
    required String message,
  }) async {
    bool success = await db.addMessage(
      senderID: senderID,
      discussionID: discussionID,
      message: message,
    );

    if (success) {
      notifyListeners();
    } else {
      debugPrint("error adding message");
    }
  }
}
