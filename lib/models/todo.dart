// Field which will be used to store the toDos in database
final String tableTasks = 'tasks';

class ToDoFields {
  static final String colId = 't_id';
  static final String colName = 't_name';
  static final String colDate = 't_date';
}

class ToDo {
  final int? id;
  final String name;
  final DateTime date;

  const ToDo({this.id, required this.name, required this.date});

  ToDo copy({int? id, String? name, DateTime? date}) =>
      ToDo(id: id ?? this.id, name: name ?? this.name, date: date ?? this.date);

  Map<String, Object?> toMap() => {
        ToDoFields.colId: id,
        ToDoFields.colName: name,
        ToDoFields.colDate: date.toIso8601String(),
      };

  static ToDo fromDatabaseMap(Map<String, Object?> map) => ToDo(
      id: map[ToDoFields.colId] as int,
      name: map[ToDoFields.colName] as String,
      date: DateTime.parse(map[ToDoFields.colDate] as String));
}
