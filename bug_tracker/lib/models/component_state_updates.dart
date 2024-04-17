import 'package:bug_tracker/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/database/db.dart';

// notifies on complaint state update
class ComplaintStateUpdates extends ChangeNotifier {
  Future<void> updateComplaintState({
    required int complaintID,
    required ComplaintState newState,
  }) async {
    bool success = await db.updateComplaintState(
      id: complaintID,
      newState: newState,
    );

    // if the process was successful notify listeners
    if (success) {
      notifyListeners();
    }
    // else debug print failed to update to acknowledged
    else {
      printStateUpdateError(attemptedState: newState.title);
    }
  }

  // notifies on complaint tag update
  Future<void> updateComplaintTags({
    required int complaintID,
    required List<Tags> newTags,
  }) async {
    bool success = await db.addTags(
      complaintID: complaintID,
      tags: newTags,
    );

    if (success) {
      notifyListeners();
    } else {
      debugPrint(
        "Failed to update tags",
      );
    }
  }
}

class TaskStateUpdates extends ChangeNotifier {
  Future<void> updateTaskState({
    required int taskID,
    required TaskState newState,
  }) async {
    bool success = await db.updateTaskState(
      id: taskID,
      newState: newState,
    );

    // if the process was successful notify listeners
    if (success) {
      notifyListeners();
    }
    // else debug print failed to update to acknowledged
    else {
      printStateUpdateError(attemptedState: newState.title);
    }
  }
}

class ProjectStateUpdates extends ChangeNotifier {
  Future<void> updateProjectState({
    required int projectID,
    required ProjectState newState,
  }) async {
    bool success = await db.updateProjectState(
      id: projectID,
      newState: newState,
    );

    // if the process was successful notify listeners
    if (success) {
      notifyListeners();
    }
    // else debug print failed to update to acknowledged
    else {
      printStateUpdateError(attemptedState: newState.title);
    }
  }
}

void printStateUpdateError({required String attemptedState}) => debugPrint(
      "Failed to update state to $attemptedState",
    );
