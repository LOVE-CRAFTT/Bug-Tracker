import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/task.dart';
import 'package:bug_tracker/database/db.dart';

// notifies on task update
class TasksUpdate extends ChangeNotifier {
  Future<void> wipeAndUpdateTasks({
    required List<Task> taskUpdates,
    required List<int> remainingOriginalTaskIDs,
  }) async {
    bool success = await db.addTasks(
        tasks: taskUpdates, remainingOriginalTaskIDs: remainingOriginalTaskIDs);

    // if addition or update of tasks is successful then notify listeners
    if (success) {
      notifyListeners();
    }
    // else debug print failed to add tasks
    else {
      debugPrint('Failed to update tasks!');
    }
  }

  Future<void> addNewTransferredTask({
    required Task task,
  }) async {
    bool success = await db.addSingleTask(task: task);

    // if addition or update of tasks is successful then notify listeners
    if (success) {
      notifyListeners();
    }
    // else debug print failed to add tasks
    else {
      debugPrint('Receiver failed to receive newly transferred task!');
    }
  }
}
