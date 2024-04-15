import 'dart:io';
import 'package:mysql1/mysql1.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/task.dart';
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
    Results result = await _conn!.query(
      'update project set project_state = ? WHERE id = ?',
      [newState.title, id],
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
  }) async {
    // Delete all existing tasks first
    Results result = await _conn!.query(
      'DELETE FROM task WHERE associated_complaint = ?',
      [tasks.first.associatedComplaint.ticketNumber],
    );
    bool successfullyDeleted =
        (result.affectedRows != null && result.affectedRows! >= 0);

    // if deletion successful then proceed
    if (successfullyDeleted) {
      // Then add all tasks
      List<Results> results = await _conn!.queryMulti(
        'insert into task (associated_complaint, task_name, task_state, due_date, associated_staff, is_team_lead) values (?, ?, ?, ?, ?, ?)',
        // list of lists
        tasks
            .map(
              (task) => [
                task.associatedComplaint.ticketNumber,
                task.task,
                task.taskState.title,
                task.dueDate.toUtc(),
                task.assignedStaff.id,
                task.isTeamLead,
              ],
            )
            .toList(),
      );
      // return true if every insert id in results.result is not null
      return results.every((result) => result.insertId != null);
    }
    // else process failure return false
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
  //============================================================================
}
