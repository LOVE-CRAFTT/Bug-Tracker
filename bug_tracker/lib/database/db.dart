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
  //============================================================================
}
