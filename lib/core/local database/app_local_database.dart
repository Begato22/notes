import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import '../utils/app_strings.dart';

class SqlDb {
  Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDB(AppStrings.databaseName);
      return _db;
    } else {
      return _db;
    }
  }

  static initDB(String databaseName) async {
    String databasePath = await getDatabasesPath();
    String path = p.join(databasePath, databaseName);
    Database myDB = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onOpen: (db) => debugPrint('DataBase Opened'),
      // onOpen: (db) => deleteDatabase(path),
    );
    return myDB;
  }

  static _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE Notes (
          id INTEGER PRIMARY KEY,
          text TEXT,
          userId TEXT,
          placeDateTime TEXT
          )
      ''');
    await db.execute('''
        CREATE TABLE User (
          id INTEGER PRIMARY KEY,
          username TEXT,
          password TEXT,
          email TEXT,
          imageAsBase64 TEXT,
          intrestId TEXT
          )
      ''');
    debugPrint('=============== Database Created Successfully ===============');
  }

  readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  insertData(String sql, List<Object?> args) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql, args);
    return response;
  }

  updateData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }
}
