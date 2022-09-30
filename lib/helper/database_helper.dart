import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _dbName = "fin_exp.db";
  static const _tableName = "Expenses";
  static const _dbVersion = 1;

  static final _col1 = "title";
  static final _col2 = "amount";
  static final payee = "payee";
  static final _main = "_id";

  // Making it a singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _intiateDatabase();

    return _database;
  }

  _intiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(_tableName,
        version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $_tableName($_main INTEGER PRIMARY KEY , $_col1 TEXT , $_col2 INTEGER , $payee TEXT)",
    );
  }

  // Insert Command
  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>?> queryAll() async {
    Database? db = await instance.database;
    return await db?.query(_tableName);
  }

  // Future update(Map<String, dynamic> row) async {
  //   Database? db = await instance.database;
  //   db?.update(_tableName, row, where: '$_col1 = ? , $_col2' , whereArgs: []);
  // }
}
