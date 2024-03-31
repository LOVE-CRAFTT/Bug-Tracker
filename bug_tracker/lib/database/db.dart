import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:mysql1/mysql1.dart';

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
  Future<Results?> getDataUsingEmailIfStaffExists(String email) async {
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

  Future<Results?> getDataUsingIDIfStaffExists(int id) async {
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
    required String password,
    required String surname,
    required String? firstName,
    required String? middleName,
  }) async {
    Results? result = await _conn?.query(
      'insert into staff (surname, first_name, middle_name, email, password, is_admin) values (?, ?, ?, ?, ?, ?)',
      [surname, firstName, middleName, email, hashPassword(password), isAdmin],
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
  Future<Results?> getDataUsingEmailIfUserExists(String email) async {
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

  Future<Results?> getDataUsingIDIfUserExists(int id) async {
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
  //============================================================================
}
