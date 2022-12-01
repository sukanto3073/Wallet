// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../ModelClass/task_model.dart';

class TaskDbHelper {
  static Database? _taskDatabase;

  Future<Database?> get db async {
    if (_taskDatabase != null) {
      return _taskDatabase!;
    }

    _taskDatabase = await initDatabase();
    return _taskDatabase;
  }

  String table = "expense.db";

  Future<Database> initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, table);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE expense 
    (  
    id INTEGER PRIMARY KEY,
    name TEXT,
    categoryid INTEGER,
    totalamount DOUBLE,
    paidamount DOUBLE,
    unpaidamount DOUBLE,
    date TEXT
    )
    ''');
  }

  Future addTask(Task task) async {
    Database? database = await db;
    return await database!.insert('expense', task.toJson());
  }

  Future<List<Task>?> getTaskModel(int id) async {
    Database? database = await db;
    var data = await database!
        .query("expense", where: 'categoryid=?', whereArgs: [id]);

    List<Task> task = data.map((task) => Task.fromJson(task)).toList();
    return task;
  }

  deleteTask(int id) async {
    Database? database = await db;
    return database!.delete("expense", where: 'id = ?', whereArgs: [id]);
  }
}
