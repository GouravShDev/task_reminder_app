// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Todo extends DataClass implements Insertable<Todo> {
  final int id;
  final String name;
  final bool isDone;
  final DateTime? due;
  final bool hasAlert;
  final int repeatMode;
  final int tasklistId;
  Todo(
      {required this.id,
      required this.name,
      required this.isDone,
      this.due,
      required this.hasAlert,
      required this.repeatMode,
      required this.tasklistId});
  factory Todo.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Todo(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      isDone: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_done'])!,
      due: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}due']),
      hasAlert: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}has_alert'])!,
      repeatMode: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}repeat_mode'])!,
      tasklistId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}tasklist_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['is_done'] = Variable<bool>(isDone);
    if (!nullToAbsent || due != null) {
      map['due'] = Variable<DateTime?>(due);
    }
    map['has_alert'] = Variable<bool>(hasAlert);
    map['repeat_mode'] = Variable<int>(repeatMode);
    map['tasklist_id'] = Variable<int>(tasklistId);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      name: Value(name),
      isDone: Value(isDone),
      due: due == null && nullToAbsent ? const Value.absent() : Value(due),
      hasAlert: Value(hasAlert),
      repeatMode: Value(repeatMode),
      tasklistId: Value(tasklistId),
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Todo(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      due: serializer.fromJson<DateTime?>(json['due']),
      hasAlert: serializer.fromJson<bool>(json['hasAlert']),
      repeatMode: serializer.fromJson<int>(json['repeatMode']),
      tasklistId: serializer.fromJson<int>(json['tasklistId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'isDone': serializer.toJson<bool>(isDone),
      'due': serializer.toJson<DateTime?>(due),
      'hasAlert': serializer.toJson<bool>(hasAlert),
      'repeatMode': serializer.toJson<int>(repeatMode),
      'tasklistId': serializer.toJson<int>(tasklistId),
    };
  }

  Todo copyWith(
          {int? id,
          String? name,
          bool? isDone,
          DateTime? due,
          bool? hasAlert,
          int? repeatMode,
          int? tasklistId}) =>
      Todo(
        id: id ?? this.id,
        name: name ?? this.name,
        isDone: isDone ?? this.isDone,
        due: due ?? this.due,
        hasAlert: hasAlert ?? this.hasAlert,
        repeatMode: repeatMode ?? this.repeatMode,
        tasklistId: tasklistId ?? this.tasklistId,
      );
  @override
  String toString() {
    return (StringBuffer('Todo(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isDone: $isDone, ')
          ..write('due: $due, ')
          ..write('hasAlert: $hasAlert, ')
          ..write('repeatMode: $repeatMode, ')
          ..write('tasklistId: $tasklistId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, isDone, due, hasAlert, repeatMode, tasklistId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Todo &&
          other.id == this.id &&
          other.name == this.name &&
          other.isDone == this.isDone &&
          other.due == this.due &&
          other.hasAlert == this.hasAlert &&
          other.repeatMode == this.repeatMode &&
          other.tasklistId == this.tasklistId);
}

class TasksCompanion extends UpdateCompanion<Todo> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> isDone;
  final Value<DateTime?> due;
  final Value<bool> hasAlert;
  final Value<int> repeatMode;
  final Value<int> tasklistId;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isDone = const Value.absent(),
    this.due = const Value.absent(),
    this.hasAlert = const Value.absent(),
    this.repeatMode = const Value.absent(),
    this.tasklistId = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.isDone = const Value.absent(),
    this.due = const Value.absent(),
    this.hasAlert = const Value.absent(),
    this.repeatMode = const Value.absent(),
    this.tasklistId = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Todo> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? isDone,
    Expression<DateTime?>? due,
    Expression<bool>? hasAlert,
    Expression<int>? repeatMode,
    Expression<int>? tasklistId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (isDone != null) 'is_done': isDone,
      if (due != null) 'due': due,
      if (hasAlert != null) 'has_alert': hasAlert,
      if (repeatMode != null) 'repeat_mode': repeatMode,
      if (tasklistId != null) 'tasklist_id': tasklistId,
    });
  }

  TasksCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<bool>? isDone,
      Value<DateTime?>? due,
      Value<bool>? hasAlert,
      Value<int>? repeatMode,
      Value<int>? tasklistId}) {
    return TasksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isDone: isDone ?? this.isDone,
      due: due ?? this.due,
      hasAlert: hasAlert ?? this.hasAlert,
      repeatMode: repeatMode ?? this.repeatMode,
      tasklistId: tasklistId ?? this.tasklistId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (due.present) {
      map['due'] = Variable<DateTime?>(due.value);
    }
    if (hasAlert.present) {
      map['has_alert'] = Variable<bool>(hasAlert.value);
    }
    if (repeatMode.present) {
      map['repeat_mode'] = Variable<int>(repeatMode.value);
    }
    if (tasklistId.present) {
      map['tasklist_id'] = Variable<int>(tasklistId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isDone: $isDone, ')
          ..write('due: $due, ')
          ..write('hasAlert: $hasAlert, ')
          ..write('repeatMode: $repeatMode, ')
          ..write('tasklistId: $tasklistId')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Todo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedColumn<bool?> isDone = GeneratedColumn<bool?>(
      'is_done', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_done IN (0, 1))',
      defaultValue: Constant(false));
  final VerificationMeta _dueMeta = const VerificationMeta('due');
  @override
  late final GeneratedColumn<DateTime?> due = GeneratedColumn<DateTime?>(
      'due', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _hasAlertMeta = const VerificationMeta('hasAlert');
  @override
  late final GeneratedColumn<bool?> hasAlert = GeneratedColumn<bool?>(
      'has_alert', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (has_alert IN (0, 1))',
      defaultValue: Constant(false));
  final VerificationMeta _repeatModeMeta = const VerificationMeta('repeatMode');
  @override
  late final GeneratedColumn<int?> repeatMode = GeneratedColumn<int?>(
      'repeat_mode', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: Constant(0));
  final VerificationMeta _tasklistIdMeta = const VerificationMeta('tasklistId');
  @override
  late final GeneratedColumn<int?> tasklistId = GeneratedColumn<int?>(
      'tasklist_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints:
          'DEFAULT 0 REFERENCES tasks_list_table(id) ON DELETE CASCADE',
      defaultValue: Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, isDone, due, hasAlert, repeatMode, tasklistId];
  @override
  String get aliasedName => _alias ?? 'tasks';
  @override
  String get actualTableName => 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Todo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_done')) {
      context.handle(_isDoneMeta,
          isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta));
    }
    if (data.containsKey('due')) {
      context.handle(
          _dueMeta, due.isAcceptableOrUnknown(data['due']!, _dueMeta));
    }
    if (data.containsKey('has_alert')) {
      context.handle(_hasAlertMeta,
          hasAlert.isAcceptableOrUnknown(data['has_alert']!, _hasAlertMeta));
    }
    if (data.containsKey('repeat_mode')) {
      context.handle(
          _repeatModeMeta,
          repeatMode.isAcceptableOrUnknown(
              data['repeat_mode']!, _repeatModeMeta));
    }
    if (data.containsKey('tasklist_id')) {
      context.handle(
          _tasklistIdMeta,
          tasklistId.isAcceptableOrUnknown(
              data['tasklist_id']!, _tasklistIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Todo map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Todo.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class TasksList extends DataClass implements Insertable<TasksList> {
  final int id;
  final String name;
  TasksList({required this.id, required this.name});
  factory TasksList.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TasksList(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  TasksListTableCompanion toCompanion(bool nullToAbsent) {
    return TasksListTableCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory TasksList.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TasksList(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  TasksList copyWith({int? id, String? name}) => TasksList(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('TasksList(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TasksList && other.id == this.id && other.name == this.name);
}

class TasksListTableCompanion extends UpdateCompanion<TasksList> {
  final Value<int> id;
  final Value<String> name;
  const TasksListTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  TasksListTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<TasksList> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  TasksListTableCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return TasksListTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksListTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $TasksListTableTable extends TasksListTable
    with TableInfo<$TasksListTableTable, TasksList> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksListTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'tasks_list_table';
  @override
  String get actualTableName => 'tasks_list_table';
  @override
  VerificationContext validateIntegrity(Insertable<TasksList> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TasksList map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TasksList.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TasksListTableTable createAlias(String alias) {
    return $TasksListTableTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TasksTable tasks = $TasksTable(this);
  late final $TasksListTableTable tasksListTable = $TasksListTableTable(this);
  late final TodoDao todoDao = TodoDao(this as AppDatabase);
  late final TasksListDao tasksListDao = TasksListDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tasks, tasksListTable];
}
