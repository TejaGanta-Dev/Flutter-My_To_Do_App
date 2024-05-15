import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/model.dart';

class DataBaseHelper {
  String tableName = 'MyToDoList';
  int id = 1;
  String title = 'title';
  String description = 'description';
  String date = 'date';
  String status = 'status';
  static DataBaseHelper _dataBaseHelper =
      DataBaseHelper._(); // Initialize directly

  DataBaseHelper._(); // Private constructor

  factory DataBaseHelper() {
    return _dataBaseHelper;
  }

  late Database _database;
  getDatabase() async {
    _database ??= await createPathDirectory();
    return _database;
  }

  Future<Database> createPathDirectory() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}MyToDoListDB.db';
    return await openDatabase(path, version: 1, onCreate: create);
  }

  create(Database _database, int version) async {
    return await _database.execute(
        'CREATE TABLE $tableName ($id INTERGER PRIMARY KEY AUTOINCREMENT, $title TEXT,$description TEXT,$status TEXT,$date TEXT)');
  }

  insert(MyToDoModel toDoModel) async {
    Database database = await this._database;
    var results = database.insert(tableName, toDoModel.toMap());
    print('inserting');
    return results;
  }
}
