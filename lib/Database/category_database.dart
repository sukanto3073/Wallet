// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../ModelClass/category_model.dart';

class CategoryDbHelper {
  static Database? _categoryDatabase;

  Future<Database?> get db async {
    if (_categoryDatabase != null) {
      return _categoryDatabase!;
    }

    _categoryDatabase = await initDatabase();
    return _categoryDatabase;
  }

  String Table = "category.db";

  Future<Database> initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, Table);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE category 
    (  
    id INTEGER PRIMARY KEY,
    name TEXT
    )
    ''');
  }

  Future addCategory(Category category) async {
    Database? database = await db;
    return await database!.insert('category', category.toJson());
  }

  Future<List<Category>?> getCategoryModel() async {
    Database? database = await db;
    var data = await database!.query("category", orderBy: "id");

    List<Category> category =
        data.map((category) => Category.fromJson(category)).toList();
    return category;
  }

  deleteCategory(int id) async {
    Database? database = await db;
    return database!.delete("category", where: 'id = ?', whereArgs: [id]);
  }
}
