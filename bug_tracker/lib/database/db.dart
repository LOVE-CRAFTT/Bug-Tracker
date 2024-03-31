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
    await Future.delayed(const Duration(milliseconds: 1));
  }

  Future<Results?> getDataIfStaffExists(String email) async {
    Results? results = await _conn?.query(
      'SELECT * FROM staff WHERE email = ?',
      [email],
    );
    if (results?.isEmpty ?? true) {
      // the condition evaluates to if null(failed query), is empty or true then
      // no staff exists
      return null;
    } else {
      // staff exists
      return results;
    }
  }

  Future<Results?> getDataIfUserExists(String email) async {
    Results? results = await _conn?.query(
      'SELECT * FROM user WHERE email = ?',
      [email],
    );
    if (results?.isEmpty ?? true) {
      // the condition evaluates to if null(failed query), is empty or true then
      // no user exists
      return null;
    } else {
      // user exists
      return results;
    }
  }

  Future<void> close() async => await _conn?.close();
}
