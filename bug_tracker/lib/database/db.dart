import 'dart:io';
import 'package:mysql1/mysql1.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/task.dart';
import 'package:bug_tracker/utilities/staff.dart';
import 'package:bug_tracker/utilities/constants.dart';

// database instance to be used throughout the project
DB db = DB();

class DB {
  MySqlConnection? _conn;

  Future<void> connect() async {
    _conn = await MySqlConnection.connect(
      ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'root',
        db: 'bug_tracker',
        password: '12345',
      ),
    );

    ///There seems to be an error with await in mysql1 package
    /// will have to be including minor pauses to wait for data
    await Future.delayed(const Duration(milliseconds: 100));
  }

  bool isConnected() {
    return _conn != null;
  }

  Future<void> close() async => await _conn?.close();

  //==================STAFF  RELATED============================================
  Future<Results?> getStaffDataUsingEmail(String email) async {
    Results results = await _conn!.query(
      'SELECT * FROM staff WHERE email = ?',
      [email],
    );
    if (results.isEmpty) {
      // no staff exists
      return null;
    } else {
      // staff exists
      return results;
    }
  }

  Future<Results?> getStaffDataUsingID(int id) async {
    Results results = await _conn!.query(
      'SELECT * FROM staff WHERE id = ?',
      [id],
    );
    if (results.isEmpty) {
      // no staff exists
      return null;
    } else {
      // staff exists
      return results;
    }
  }

  Future<int?> addNewStaff({
    required bool isAdmin,
    required String email,
    required String surname,
    required String? firstName,
    required String? middleName,
  }) async {
    Results result = await _conn!.query(
      'insert into staff (surname, first_name, middle_name, email, password, is_admin) values (?, ?, ?, ?, ?, ?)',
      [surname, firstName, middleName, email, hashPassword("000000"), isAdmin],
    );
    return result.insertId;
  }

  Future<bool> updateStaffPassword({
    required int id,
    required String password,
  }) async {
    Results result = await _conn!.query(
      'update staff set password = ? WHERE id = ?',
      [hashPassword(password), id],
    );

    //success
    if (result.insertId != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<Results?> getAllStaff() async {
    Results results = await _conn!.query(
      'SELECT * FROM staff',
    );
    if (results.isEmpty) {
      // No staff
      return null;
    } else {
      // staff exists
      return results;
    }
  }

  Future<Results?> getAllStaffInBatches({required int limit}) async {
    Results results = await _conn!.query(
      'SELECT * FROM staff LIMIT $limit',
    );
    if (results.isEmpty) {
      // No staff
      return null;
    } else {
      // staff exists
      return results;
    }
  }

  Future<bool> updateStaffEmail({
    required int staffID,
    required String newEmail,
  }) async {
    Results result = await _conn!.query(
      'update staff set email = ? WHERE id = ?',
      [newEmail, staffID],
    );

    //success
    if (result.insertId != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateStaffName({
    required int staffID,
    required String surname,
    required String? firstName,
    required String? middleName,
  }) async {
    Results result = await _conn!.query(
      'update staff set surname = ?, first_name = ?, middle_name = ? WHERE id = ?',
      [surname, firstName, middleName, staffID],
    );

    //success
    if (result.insertId != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> wipeStaffDataFromDatabase({required int staffId}) async {
    // deleted in particular order to prevent
    // foreign key constraint violations

    // Delete associated staff from calendar_events
    Results results = await _conn!.query(
      'DELETE FROM calendar_events WHERE associated_staff = ?',
      [staffId],
    );
    if (results.affectedRows == null || results.affectedRows! < 0) {
      return false;
    }

    // Delete staff id from conversation_participants
    results = await _conn!.query(
      'DELETE FROM conversation_participants WHERE staff_id = ?',
      [staffId],
    );
    if (results.affectedRows == null || results.affectedRows! < 0) {
      return false;
    }

    // Delete staff id from messages
    results = await _conn!.query(
      'DELETE FROM messages WHERE staff_id = ?',
      [staffId],
    );
    if (results.affectedRows == null || results.affectedRows! < 0) {
      return false;
    }

    // Delete associated_staff from task
    results = await _conn!.query(
      'DELETE FROM task WHERE associated_staff = ?',
      [staffId],
    );
    if (results.affectedRows == null || results.affectedRows! < 0) {
      return false;
    }

    // Delete id from staff
    results = await _conn!.query(
      'DELETE FROM staff WHERE id = ?',
      [staffId],
    );
    if (results.affectedRows == null || results.affectedRows! <= 0) {
      return false;
    }

    return true;
  }

  //============================================================================

  //===================USER RELATED=============================================
  Future<Results?> getUserDataUsingEmail(String email) async {
    Results results = await _conn!.query(
      'SELECT * FROM user WHERE email = ?',
      [email],
    );
    if (results.isEmpty) {
      // no user exists
      return null;
    } else {
      // user exists
      return results;
    }
  }

  Future<Results?> getUserDataUsingID(int id) async {
    Results results = await _conn!.query(
      'SELECT * FROM user WHERE id = ?',
      [id],
    );
    if (results.isEmpty) {
      // no user exists
      return null;
    } else {
      // user exists
      return results;
    }
  }

  Future<int?> addNewUser({
    required String email,
    required String password,
    required String surname,
    required String? firstName,
    required String? middleName,
  }) async {
    Results result = await _conn!.query(
      'insert into user (surname, first_name, middle_name, email, password) values (?, ?, ?, ?, ?)',
      [surname, firstName, middleName, email, hashPassword(password)],
    );
    return result.insertId;
  }

  Future<bool> updateUserPassword({
    required int id,
    required String password,
  }) async {
    Results result = await _conn!.query(
      'update user set password = ? WHERE id = ?',
      [hashPassword(password), id],
    );

    //success
    if (result.insertId != null) {
      return true;
    } else {
      return false;
    }
  }
  //============================================================================

  //=================PROJECT RELATED============================================
  Future<int?> addNewProject({
    required String projectName,
    required String? projectDetails,
  }) async {
    Results result = await _conn!.query(
      'insert into project (name, details, project_state, date_created, date_closed) values (?, ?, ?, ?, ?)',
      [
        projectName,
        projectDetails,
        ProjectState.open.title,
        DateTime.now().toUtc(),
        null
      ],
    );
    return result.insertId;
  }

  Future<Results?> getProjectData(int id) async {
    Results results = await _conn!.query(
      'SELECT * FROM project WHERE id = ?',
      [id],
    );
    if (results.isEmpty) {
      // no such project exists
      return null;
    } else {
      // project exists
      return results;
    }
  }

  Future<Results?> getAllProjects({required int limit}) async {
    Results results = await _conn!.query(
      'SELECT * FROM project LIMIT $limit',
    );
    if (results.isEmpty) {
      // No projects
      return null;
    } else {
      // projects exist
      return results;
    }
  }

  Future<bool> updateProjectState({
    required int id,
    required ProjectState newState,
  }) async {
    Results result = newState == ProjectState.closed
        ? await _conn!.query(
            'update project set project_state = ?, date_closed = ? WHERE id = ?',
            [newState.title, DateTime.now().toUtc(), id],
          )
        : await _conn!.query(
            'update project set project_state = ?, date_closed = ? WHERE id = ?',
            [newState.title, null, id],
          );

    //success
    if (result.insertId != null) {
      return true;
    } else {
      return false;
    }
  }
  //============================================================================

  //=================COMPLAINT RELATED==========================================
  Future<int?> addComplaint({
    required String complaintTitle,
    required String? complaintNotes,
    required int associatedProject,
    required int author,
  }) async {
    Results result = await _conn!.query(
      'insert into complaint (title, notes, associated_project, author, date_created, complaint_state) values (?, ?, ?, ?, ?, ?)',
      [
        complaintTitle,
        complaintNotes,
        associatedProject,
        author,
        DateTime.now().toUtc(),
        ComplaintState.pending.title,
      ],
    );
    return result.insertId;
  }

  Future<bool> addTags({
    required int complaintID,
    required List<Tags> tags,
  }) async {
    // Delete all existing tags first
    Results result = await _conn!.query(
      'DELETE FROM tags WHERE associated_complaint = ?',
      [complaintID],
    );
    bool successfullyDeleted =
        (result.affectedRows != null && result.affectedRows! >= 0);

    // if deletion successful then proceed
    if (successfullyDeleted) {
      // after deletion check if tags list is empty meaning request for
      // removal of all tags
      // if so return true
      if (tags.isEmpty) return true;

      // Then add all tags
      List<Results> results = await _conn!.queryMulti(
        'insert into tags (associated_complaint, tag) values (?, ?)',
        // list of lists
        tags.map((tag) => [complaintID, tag.title]).toList(),
      );
      // return true if every insert id in results.result is not null
      return results.every((result) => result.insertId != null);
    }
    // else process failure return false
    else {
      return false;
    }
  }

  Future<bool> addStaffNote({
    required int complaintID,
    required String note,
  }) async {
    Results result = await _conn!.query(
      'insert into staff_note (note, associated_complaint) values (?, ?)',
      [note, complaintID],
    );

    if (result.insertId != null) {
      // note successfully added
      return true;
    } else {
      // failure
      return false;
    }
  }

  Future<bool> addComplaintFiles({
    required List<File> files,
    required int associatedComplaint,
  }) async {
    List<Results> results = await _conn!.queryMulti(
      'insert into files (file_path, associated_complaint) values (?, ?)',
      // list of lists
      files.map((file) => [file.path, associatedComplaint]).toList(),
    );
    // return true if every insert id in results.result is not null
    // if results is empty it returns true which is ok
    // since it means files might not have been added
    return results.every((result) => result.insertId != null);
  }

  Future<Results?> getAllComplaints({required int limit}) async {
    Results results = await _conn!.query(
      'SELECT * FROM complaint ORDER BY date_created DESC LIMIT $limit',
    );
    if (results.isEmpty) {
      // No complaints
      return null;
    } else {
      // complaint exists
      return results;
    }
  }

  Future<Results?> getComplaintsByUser({
    required int userID,
    required int limit,
  }) async {
    Results results = await _conn!.query(
      'SELECT * FROM complaint WHERE author = ? ORDER BY date_created DESC LIMIT ?',
      [userID, limit],
    );

    if (results.isEmpty) {
      return null;
    } else {
      return results;
    }
  }

  Future<Results?> getComplaintsByProject({
    required int projectID,
    required int limit,
  }) async {
    Results results = await _conn!.query(
      'SELECT * FROM complaint WHERE associated_project = ? ORDER BY date_created DESC LIMIT ?',
      [projectID, limit],
    );

    if (results.isEmpty) {
      return null;
    } else {
      return results;
    }
  }

  Future<Results?> getComplaintData(int id) async {
    Results result = await _conn!.query(
      'SELECT * FROM complaint WHERE id = ?',
      [id],
    );
    if (result.isEmpty) {
      // no such complaint exists
      return null;
    } else {
      // complaint exists
      return result;
    }
  }

  Future<Results?> getStaffNotes(int complaintID) async {
    Results results = await _conn!.query(
      'SELECT * FROM staff_note WHERE associated_complaint = ?',
      [complaintID],
    );
    if (results.isEmpty) {
      // no complaint notes associated with this complaint
      return null;
    } else {
      // return the notes
      return results;
    }
  }

  Future<bool> updateComplaintState({
    required int id,
    required ComplaintState newState,
  }) async {
    Results result = await _conn!.query(
      'update complaint set complaint_state = ? WHERE id = ?',
      [newState.title, id],
    );

    //success
    if (result.insertId != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<Results?> getTags({required int complaintID}) async {
    Results results = await _conn!.query(
      'SELECT * FROM tags WHERE associated_complaint = $complaintID',
    );
    if (results.isEmpty) {
      // No tags
      return null;
    } else {
      // tags exists
      return results;
    }
  }

  Future<Results?> getComplaintFiles({required int complaintID}) async {
    Results results = await _conn!.query(
      'SELECT * FROM files WHERE associated_complaint = $complaintID',
    );
    if (results.isEmpty) {
      // No files
      return null;
    } else {
      // there are some files
      return results;
    }
  }

  //============================================================================

  //=================TASK RELATED===============================================
  Future<Results?> getTasksByComplaint({
    required int complaintID,
  }) async {
    Results results = await _conn!.query(
      'SELECT * FROM task WHERE associated_complaint = ?',
      [complaintID],
    );
    if (results.isEmpty) {
      // No associated tasks
      return null;
    } else {
      // tasks exist
      return results;
    }
  }

  Future<Results?> getTasksByStaff({
    required int staffID,
    required int limit,
  }) async {
    Results results = await _conn!.query(
      'SELECT * FROM task WHERE associated_staff = ? LIMIT ?',
      [staffID, limit],
    );
    if (results.isEmpty) {
      // no associated tasks
      return null;
    } else {
      // tasks exist
      return results;
    }
  }

  Future<Results?> getTaskData(int id) async {
    Results result = await _conn!.query(
      'SELECT * FROM task WHERE id = ?',
      [id],
    );
    if (result.isEmpty) {
      // no such complaint exists
      return null;
    } else {
      // complaint exists
      return result;
    }
  }

  Future<bool> addTasks({
    required List<Task> tasks,
    required List<int> preservedOriginalTaskIDs,
  }) async {
    int relatedComplaintID = tasks.first.associatedComplaint.ticketNumber;

    // Delete all existing tasks first
    Results result = await _conn!.query(
      'DELETE FROM task WHERE associated_complaint = ?',
      [relatedComplaintID],
    );
    bool successfullyDeleted =
        (result.affectedRows != null && result.affectedRows! >= 0);

    // divide into the ones with or without the preservedOriginalTaskIDs
    // with
    List<Task> preservedOriginalTasks = tasks
        .where((task) => preservedOriginalTaskIDs.contains(task.id))
        .toList();
    // without
    tasks.removeWhere((task) => preservedOriginalTasks.contains(task));

    // if deletion successful then proceed
    if (successfullyDeleted) {
      // Then insert tasks that don't require extra work
      List<Results> results = await _conn!.queryMulti(
        'insert into task (associated_complaint, task_name, task_state, due_date, associated_staff, is_team_lead) values (?, ?, ?, ?, ?, ?)',
        // list of lists
        tasks
            .map(
              (task) => [
                relatedComplaintID,
                task.task,
                task.taskState.title,
                task.dueDate.toUtc(),
                task.assignedStaff.id,
                task.isTeamLead,
              ],
            )
            .toList(),
      );

      // if successful in inserting tasks that don't need updating in sessions table
      if (results.every((result) => result.insertId != null)) {
        // insert tasks requiring extra work
        results = await _conn!.queryMulti(
          'insert into task (associated_complaint, task_name, task_state, due_date, associated_staff, is_team_lead) values (?, ?, ?, ?, ?, ?)',
          // list of lists
          preservedOriginalTasks
              .map(
                (task) => [
                  relatedComplaintID,
                  task.task,
                  task.taskState.title,
                  task.dueDate.toUtc(),
                  task.assignedStaff.id,
                  task.isTeamLead,
                ],
              )
              .toList(),
        );

        // if successful in inserting tasks that need updating in sessions table
        if (results.every((result) => result.insertId != null)) {
          List<int> newIds = results.map((result) => result.insertId!).toList();

          String placeholders =
              List<String>.filled(preservedOriginalTaskIDs.length, '?')
                  .join(',');

          // delete unreferenced from session
          await _conn!.query(
            'DELETE FROM work_sessions WHERE associated_complaint = ? AND task_id NOT IN ($placeholders)',
            [
              relatedComplaintID,
              ...preservedOriginalTaskIDs,
            ],
          );

          // replace in sessions
          for (int i = 0; i < newIds.length; i++) {
            await _conn!.query(
              'UPDATE work_sessions SET task_id = ? where task_id = ?;',
              [newIds[i], preservedOriginalTaskIDs[i]],
            );
          }

          return true;
        }
        // failure in inserting more work tasks
        else {
          return false;
        }
      }
      // failure in inserting less work tasks
      else {
        return false;
      }
    }
    // else failed to delete all tasks, return false
    else {
      return false;
    }
  }

  Future<bool> updateTaskState({
    required int id,
    required TaskState newState,
  }) async {
    Results result = await _conn!.query(
      'update task set task_state = ? WHERE id = ?',
      [newState.title, id],
    );

    //success
    if (result.insertId != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addSingleTask({
    required Task task,
  }) async {
    Results result = await _conn!.query(
        'insert into task (associated_complaint, task_name, task_state, due_date, associated_staff, is_team_lead) values (?, ?, ?, ?, ?, ?)',
        [
          task.associatedComplaint.ticketNumber,
          task.task,
          task.taskState.title,
          task.dueDate.toUtc(),
          task.assignedStaff.id,
          task.isTeamLead,
        ]);

    if (result.insertId != null) {
      // task successfully added
      return true;
    } else {
      // failure
      return false;
    }
  }
  //============================================================================

  //=================WORK SESSION RELATED=======================================
  Future<Results?> getActiveWorkSession({required int taskID}) async {
    Results result = await _conn!.query(
      'SELECT * FROM work_sessions WHERE task_id = ? AND time_ended IS NULL ORDER BY time_started DESC',
      [taskID],
    );

    if (result.isEmpty) {
      return null;
    } else {
      return result;
    }
  }

  Future<int?> addWorkSession({required Task task}) async {
    Results result = await _conn!.query(
      'INSERT INTO work_sessions (task_id, associated_staff, associated_complaint, time_started, time_ended) VALUES (?, ?, ?, ?, ?)',
      [
        task.id,
        task.assignedStaff.id,
        task.associatedComplaint.ticketNumber,
        DateTime.now().toUtc(),
        null,
      ],
    );

    if (result.insertId != null) {
      return result.insertId!;
    } else {
      return null;
    }
  }

  Future<bool> updateSessionEndTime({required int sessionID}) async {
    Results result = await _conn!.query(
      "UPDATE work_sessions SET time_ended = ? WHERE id = ?",
      [
        DateTime.now().toUtc(),
        sessionID,
      ],
    );

    if (result.affectedRows != null && result.affectedRows! > 0) {
      return true;
    } else {
      return false;
    }
  }

  //============================================================================

  //=================CALENDAR RELATED===========================================
  Future<Results?> getCalendarEvents({required int staffID}) async {
    Results result = await _conn!.query(
      'SELECT * FROM calendar_events WHERE associated_staff = ?',
      [staffID],
    );
    if (result.isEmpty) {
      // no related events
      return null;
    } else {
      // return events
      return result;
    }
  }

  Future<bool> addCalendarActivity({
    required int staffID,
    required DateTime date,
    required String title,
  }) async {
    Results results = await _conn!.query(
      'insert into calendar_events (associated_staff, date, event_title) values (?, ?, ?)',
      [
        staffID,
        date.toUtc(),
        title,
      ],
    );

    // if successful return true
    if (results.insertId != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteCalendarActivity({required int id}) async {
    Results results = await _conn!.query(
      'DELETE FROM calendar_events WHERE id = ?',
      [id],
    );

    // If affectedRows is not null and greater than 0, the deletion was successful
    if (results.affectedRows != null && results.affectedRows! > 0) {
      return true;
    } else {
      return false;
    }
  }

  //============================================================================

  //=================DISCUSSION RELATED=========================================
  Future<bool> addDiscussion({
    required String title,
    required List<Staff> participants,
  }) async {
    // first insert title to get an id
    Results result = await _conn!.query(
      'insert into conversations (title) values (?)',
      [title],
    );

    // if successful then add participants
    if (result.insertId != null) {
      int conversationID = result.insertId!;

      List<Results> results = await _conn!.queryMulti(
        'insert into conversation_participants (conversation_id, staff_id) values (?, ?)',
        participants.map((staff) => [conversationID, staff.id]).toList(),
      );

      // if insertion was successful then return true
      if (results.every((result) => result.insertId != null)) {
        return true;
      }
      // else on participant addition failure
      else {
        return false;
      }
    }
    // else on title addition failure
    else {
      return false;
    }
  }

  Future<Results?> getStaffDiscussions({
    required int staffID,
    required int limit,
  }) async {
    Results results = await _conn!.query(
      'SELECT conversation_id FROM conversation_participants WHERE staff_id = ? LIMIT ?',
      [staffID, limit],
    );

    if (results.isNotEmpty) {
      // staff is a participant in at least one discussion
      return results;
    } else {
      // staff is not a participant in any discussions
      return null;
    }
  }

  Future<Results?> getDiscussionTitle({required int discussionID}) async {
    Results result = await _conn!.query(
      'SELECT title FROM conversations WHERE conversation_id = ?',
      [discussionID],
    );

    // title exists
    if (result.isNotEmpty) {
      return result;
    }
    // no title
    else {
      return null;
    }
  }

  Future<Results?> getAllParticipantsInDiscussion({
    required int discussionID,
  }) async {
    Results results = await _conn!.query(
      'SELECT staff_id FROM conversation_participants WHERE conversation_id = ?',
      [discussionID],
    );

    // participants exists
    if (results.isNotEmpty) {
      return results;
    }
    // no participants
    else {
      return null;
    }
  }

  Future<bool> addMessage({
    required int senderID,
    required int discussionID,
    required String message,
  }) async {
    Results result = await _conn!.query(
      'insert into messages (conversation_id, staff_id, message, time_created) values (?, ?, ?, ?)',
      [
        discussionID,
        senderID,
        message,
        DateTime.now().toUtc(),
      ],
    );

    // if insert successfully
    if (result.insertId != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<Results?> getMessagesInBatches({
    required int discussionID,
    required int limit,
  }) async {
    Results results = await _conn!.query(
      'SELECT staff_id, message FROM messages WHERE conversation_id = ? ORDER BY time_created DESC LIMIT ?',
      [discussionID, limit],
    );

    // there are some messages
    if (results.isNotEmpty) {
      return results;
    }
    // no messages
    else {
      return null;
    }
  }
  //============================================================================
}
