import 'dart:io';

import 'package:loaylity_app/model/profile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = documentDirectory.path + '${Profile.table}.db';
    return await openDatabase(path, version: 1, onCreate: createTable,
        onConfigure: (Database database) async {
      await database.execute('PRAGMA foreign_keys = ON');
    });
  }

  void createTable(Database database, int version) async {
    await database.execute(
        'CREATE TABLE ${Profile.table} (id INTEGER PRIMARY KEY NOT NULL,login TEXT NOT NULL, name TEXT NOT NULL, surname TEXT, patronymic TEXT NOT NULL, telephone_number INTEGER NOT NULL,password TEXT NOT NULL,loyalty_number INTEGER NOT NULL,loyalty_name TEXT NOT NULL,birth_date TEXT NOT NULL)');
  }
}
