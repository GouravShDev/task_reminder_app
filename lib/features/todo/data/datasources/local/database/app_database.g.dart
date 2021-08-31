// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TodoDao? _todoDaoInstance;

  TaskListDao? _taskListDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tasks` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `due` TEXT NOT NULL, `isDone` INTEGER NOT NULL, `hasAlert` INTEGER NOT NULL, `repeatMode` INTEGER NOT NULL, `taskListId` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `task_lists` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TodoDao get todoDao {
    return _todoDaoInstance ??= _$TodoDao(database, changeListener);
  }

  @override
  TaskListDao get taskListDao {
    return _taskListDaoInstance ??= _$TaskListDao(database, changeListener);
  }
}

class _$TodoDao extends TodoDao {
  _$TodoDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _toDoInsertionAdapter = InsertionAdapter(
            database,
            'tasks',
            (ToDo item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'due': _dateTimeConverter.encode(item.due),
                  'isDone': item.isDone ? 1 : 0,
                  'hasAlert': item.hasAlert ? 1 : 0,
                  'repeatMode': item.repeatMode,
                  'taskListId': item.taskListId
                }),
        _toDoDeletionAdapter = DeletionAdapter(
            database,
            'tasks',
            ['id'],
            (ToDo item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'due': _dateTimeConverter.encode(item.due),
                  'isDone': item.isDone ? 1 : 0,
                  'hasAlert': item.hasAlert ? 1 : 0,
                  'repeatMode': item.repeatMode,
                  'taskListId': item.taskListId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ToDo> _toDoInsertionAdapter;

  final DeletionAdapter<ToDo> _toDoDeletionAdapter;

  @override
  Future<List<ToDo>> getAllTodos() async {
    return _queryAdapter.queryList('SELECT * FROM tasks ORDER BY due ASC',
        mapper: (Map<String, Object?> row) => ToDo(
            id: row['id'] as int?,
            name: row['name'] as String,
            due: _dateTimeConverter.decode(row['due'] as String),
            isDone: (row['isDone'] as int) != 0,
            hasAlert: (row['hasAlert'] as int) != 0,
            repeatMode: row['repeatMode'] as int,
            taskListId: row['taskListId'] as int));
  }

  @override
  Future<ToDo?> getTodoById(int id) async {
    return _queryAdapter.query('SELECT * FROM tasks WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ToDo(
            id: row['id'] as int?,
            name: row['name'] as String,
            due: _dateTimeConverter.decode(row['due'] as String),
            isDone: (row['isDone'] as int) != 0,
            hasAlert: (row['hasAlert'] as int) != 0,
            repeatMode: row['repeatMode'] as int,
            taskListId: row['taskListId'] as int),
        arguments: [id]);
  }

  @override
  Future<int> insertTodo(ToDo todo) {
    return _toDoInsertionAdapter.insertAndReturnId(
        todo, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteTodo(ToDo todo) async {
    await _toDoDeletionAdapter.delete(todo);
  }
}

class _$TaskListDao extends TaskListDao {
  _$TaskListDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _taskListInsertionAdapter = InsertionAdapter(
            database,
            'task_lists',
            (TaskList item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TaskList> _taskListInsertionAdapter;

  @override
  Future<List<TaskList>> getAllTaskLists() async {
    return _queryAdapter.queryList('SELECT * FROM task_lists',
        mapper: (Map<String, Object?> row) =>
            TaskList(id: row['id'] as int?, name: row['name'] as String));
  }

  @override
  Future<int> insertTaskList(TaskList taskList) {
    return _taskListInsertionAdapter.insertAndReturnId(
        taskList, OnConflictStrategy.ignore);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
final _boolConverter = BoolConverter();
