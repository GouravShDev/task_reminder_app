// Field which will be used to store the toDos in database
final String tableTasks = 'tasks';

class ToDoFields {
  static final String colId = 't_id';
  static final String colName = 'name';
  static final String colDue = 'due';
  static final String colAlert = 'HasAlert';
  static final String colCompleted = 'isFinished';
}

class ToDo {
  final int? id;
  final String name;
  final DateTime due;
  int hasAlert;
  int isFinished;

  ToDo(
      {this.id,
      required this.name,
      required this.due,
      this.hasAlert = 0,
      this.isFinished = 0});

  // This method create copy of the object with new Id received from database
  ToDo copy({int? id, String? name, DateTime? date}) => ToDo(
        id: id ?? this.id,
        name: name ?? this.name,
        due: date ?? this.due,
        hasAlert: this.hasAlert,
        isFinished: this.isFinished,
      );

  Map<String, Object?> toMap() => {
        ToDoFields.colId: id,
        ToDoFields.colName: name,
        ToDoFields.colDue: due.toIso8601String(),
      };

  static ToDo fromDatabaseMap(Map<String, Object?> map) => ToDo(
      id: map[ToDoFields.colId] as int,
      name: map[ToDoFields.colName] as String,
      due: DateTime.parse(map[ToDoFields.colDue] as String));

  void setAlert(bool hasAlert) {
    this.hasAlert = hasAlert ? 1 : 0;
  }

  void setFinished(bool isFinished) {
    this.isFinished = isFinished ? 1 : 0;
  }
}
