import 'package:bug_tracker/utilities/task.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/database/db.dart';

// notifies on task update
class TasksUpdate extends ChangeNotifier {
  Future<void> updateTasks({required List<Task> taskUpdates}) async {
    bool success = await db.addTasks(tasks: taskUpdates);

    // if addition or update of tasks is successful then notify listeners
    if (success) {
      notifyListeners();
    }
    // else debug print failed to add tasks
    else {
      debugPrint('Failed to update tasks!');
    }
  }
}
