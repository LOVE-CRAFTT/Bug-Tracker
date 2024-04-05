import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:mysql1/mysql1.dart';
import 'dart:io';

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
    Results? results = await _conn?.query(
      'SELECT * FROM staff WHERE email = ?',
      [email],
    );
    if (results?.isEmpty ?? true) {
      // the condition evaluates to if null(failed query) or is empty then
      // no staff exists
      return null;
    } else {
      // staff exists
      return results;
    }
  }

  Future<Results?> getStaffDataUsingID(int id) async {
    Results? results = await _conn?.query(
      'SELECT * FROM staff WHERE id = ?',
      [id],
    );
    if (results?.isEmpty ?? true) {
      // the condition evaluates to if null(failed query) or is empty then
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
    Results? result = await _conn?.query(
      'insert into staff (surname, first_name, middle_name, email, password, is_admin) values (?, ?, ?, ?, ?, ?)',
      [surname, firstName, middleName, email, hashPassword("000000"), isAdmin],
    );
    return result?.insertId;
  }

  Future<bool> updateStaffPassword({
    required int id,
    required String password,
  }) async {
    Results? result = await _conn?.query(
      'update staff set password = ? WHERE id = ?',
      [hashPassword(password), id],
    );

    //success
    if (result?.insertId != null) {
      return true;
    } else {
      return false;
    }
  }
  //============================================================================

  //===================USER RELATED=============================================
  Future<Results?> getUserDataUsingEmail(String email) async {
    Results? results = await _conn?.query(
      'SELECT * FROM user WHERE email = ?',
      [email],
    );
    if (results?.isEmpty ?? true) {
      // the condition evaluates to if null(failed query) or is empty then
      // no user exists
      return null;
    } else {
      // user exists
      return results;
    }
  }

  Future<Results?> getUserDataUsingID(int id) async {
    Results? results = await _conn?.query(
      'SELECT * FROM user WHERE id = ?',
      [id],
    );
    if (results?.isEmpty ?? true) {
      // the condition evaluates to if null(failed query) or is empty then
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
    Results? result = await _conn?.query(
      'insert into user (surname, first_name, middle_name, email, password) values (?, ?, ?, ?, ?)',
      [surname, firstName, middleName, email, hashPassword(password)],
    );
    return result?.insertId;
  }

  Future<bool> updateUserPassword({
    required int id,
    required String password,
  }) async {
    Results? result = await _conn?.query(
      'update user set password = ? WHERE id = ?',
      [hashPassword(password), id],
    );

    //success
    if (result?.insertId != null) {
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
    Results? result = await _conn?.query(
      'insert into project (name, details, project_state, date_created, date_closed) values (?, ?, ?, ?, ?)',
      [
        projectName,
        projectDetails,
        ProjectState.open.title,
        DateTime.now().toUtc(),
        null
      ],
    );
    return result?.insertId;
  }

  Future<Results?> getProjectData(int id) async {
    Results? results = await _conn?.query(
      'SELECT * FROM project WHERE id = ?',
      [id],
    );
    if (results?.isEmpty ?? true) {
      // the condition evaluates to if null(failed query) or is empty then
      // no such project exists
      return null;
    } else {
      // project exists
      return results;
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
    Results? result = await _conn?.query(
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
    return result?.insertId;
  }

  Future<bool?> addTags({
    required int complaintID,
    required List<Tags> tags,
  }) async {
    // Delete all existing tags first
    Results? result = await _conn?.query(
      'DELETE FROM tags WHERE associated_complaint = ?',
      [complaintID],
    );
    bool successfullyDeleted = (result != null &&
        result.affectedRows != null &&
        result.affectedRows! >= 0);

    // if deletion successful then proceed
    if (successfullyDeleted) {
      // after deletion check if tags list is empty meaning request for
      // removal of all tags
      // if so return true
      if (tags.isEmpty) return true;

      // Then add all tags
      List<Results>? results = await _conn?.queryMulti(
        'insert into tags (associated_complaint, tag) values (?, ?)',
        // list of lists
        tags.map((tag) => [complaintID, tag.title]).toList(),
      );
      // return true if every insert id in results.result is not null
      return results?.every((result) => result.insertId != null);
    }
    // else process failure return null
    else {
      return null;
    }
  }

  Future<bool?> addComplaintFiles({
    required List<File> files,
    required int associatedComplaint,
  }) async {
    List<Results>? results = await _conn?.queryMulti(
      'insert into files (file_path, associated_complaint) values (?, ?)',
      // list of lists
      files.map((file) => [file.path, associatedComplaint]).toList(),
    );
    // return true if every insert id in results.result is not null
    // if results is empty it returns true which is ok
    // since it means files might not have been added
    return results?.every((result) => result.insertId != null);
  }

  Future<Results?> getAllComplaints({required int limit}) async {
    Results? results = await _conn?.query(
      'SELECT * FROM complaint ORDER BY date_created DESC LIMIT $limit',
    );
    if (results?.isEmpty ?? true) {
      // No complaints
      return null;
    } else {
      // complaint exists
      return results;
    }
  }

  //NOTE: This shouldn't be necessary as I should filter on the complaint source list
  // though a potential error is not knowing what exactly has populated the complaints Source
  Future<Results?> getComplaintsFilteredByState({
    required int limit,
    required ComplaintState state,
  }) async {
    Results? results = await _conn?.query(
      'SELECT * FROM complaint WHERE complaint_state = ? ORDER BY date_created DESC LIMIT ?',
      [state.title, limit],
    );
    if (results?.isEmpty ?? true) {
      // No complaints
      return null;
    } else {
      // complaint exists
      return results;
    }
  }

  Future<Results?> getComplaintData(int id) async {
    Results? result = await _conn?.query(
      'SELECT * FROM complaint WHERE id = ?',
      [id],
    );
    if (result?.isEmpty ?? true) {
      // the condition evaluates to if null(failed query) or is empty then
      // no such complaint exists
      return null;
    } else {
      // complaint exists
      return result;
    }
  }

  Future<bool> updateComplaintState({
    required int id,
    required ComplaintState newState,
  }) async {
    Results? result = await _conn?.query(
      'update complaint set complaint_state = ? WHERE id = ?',
      [newState.title, id],
    );

    //success
    if (result?.insertId != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<Results?> getTags({required int complaintID}) async {
    Results? results = await _conn?.query(
      'SELECT * FROM tags WHERE associated_complaint = $complaintID',
    );
    if (results?.isEmpty ?? true) {
      // No tags
      return null;
    } else {
      // tags exists
      return results;
    }
  }

  Future<Results?> getComplaintFiles({required int complaintID}) async {
    Results? results = await _conn?.query(
      'SELECT * FROM files WHERE associated_complaint = $complaintID',
    );
    if (results?.isEmpty ?? true) {
      // No files
      return null;
    } else {
      // there are some files
      return results;
    }
  }

  //============================================================================
}
