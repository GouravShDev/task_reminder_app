import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:todo_list_app/models/todo.dart';

class ToDoDatabase {
  static ToDoDatabase? _dbHelper;
  static Database? _database;

  ToDoDatabase._createInstance();

  factory ToDoDatabase() {
    if (_dbHelper == null) {
      _dbHelper = ToDoDatabase._createInstance();
    }
    return _dbHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + 'tasks.db';
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    final nameType = "TEXT NOT NULL";
    final dateType = "TEXT";
    await db.execute('''
    CREATE TABLE $tableTasks(
      ${ToDoFields.colId} $idType,
      ${ToDoFields.colName} $nameType,
      ${ToDoFields.colDate} $dateType
    )  
    ''');
  }

  // Insert Operation : Insert a ToDo Object to Database
  Future<ToDo> insertTask(ToDo todo) async {
    Database db = await this.database;
    final id = await db.insert(tableTasks, todo.toMap());
    // print(result);
    return todo.copy(id: id);
  }

  // Fetch Operation: Get ToDo from database using id
  Future<ToDo?> getTaskById(int id) async {
    var db = await this.database;
    var toDoMap = await db
        .query(tableTasks, where: '${ToDoFields.colId} = ?', whereArgs: [id]);
    if (toDoMap.isEmpty) {
      return null;
    } else {
      return ToDo.fromDatabaseMap(toDoMap.first);
    }
  }

  // Fetch Operation : Get all ToDo from Database
  Future<List<ToDo>> getTaskMapList() async {
    Database db = await this.database;
    final orderBy = '${ToDoFields.colDate} DESC';

    final result = await db.query(tableTasks, orderBy: orderBy);
    return result.map((e) => ToDo.fromDatabaseMap(e)).toList();
  }

  // Update Operation : Update ToDo Object and save it to Database
  Future<int> updateTask(ToDo todo) async {
    var db = await this.database;
    var result = db.update(tableTasks, todo.toMap(),
        where: '${ToDoFields.colId} = ?', whereArgs: [todo.id]);
    return result;
  }

  // Delete Operation : Delete the ToDo object from Database using id
  Future<int> deleteTask(int id) async {
    var db = await this.database;
    int result = await db
        .delete(tableTasks, where: '${ToDoFields.colId} = ?', whereArgs: [id]);
    return result;
  }

  Future close() async {
    final db = await _dbHelper!.database;
    db.close();
  }
}
