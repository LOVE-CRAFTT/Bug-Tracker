import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:bug_tracker/utilities/tools.dart';

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
  }

  Future<void> addAdmin() async {
    var result = await _conn?.query(
      'insert into staff (email, password, is_admin, surname, first_name, middle_name) values (?, ?, ?, ?, ?, ?)',
      [
        'johnPaul@gmail.com',
        hashPassword("123456"),
        true,
        "Smith",
        "John",
        "Paul",
      ],
    );
    debugPrint(result.toString());
  }

  Future<void> close() async => await _conn?.close();
}
