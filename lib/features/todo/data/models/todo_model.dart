import '../../domain/entities/todo.dart';

class ToDoFields {
  static final String colId = 'id';
  static final String colName = 'name';
  static final String colDue = 'due';
  static final String colAlert = 'hasAlert';
  static final String colCompleted = 'isDone';
}

class ToDoModel extends ToDo {
  ToDoModel({
    required id,
    required name,
    required due,
    required isDone,
    required hasAlert,
  }) : super(id: id, name: name, due: due, isDone: isDone, hasAlert: hasAlert);

  factory ToDoModel.fromDatabaseJson(Map<String, dynamic> json) {
    return ToDoModel(
      id: json[ToDoFields.colId],
      name: json[ToDoFields.colName],
      due: DateTime.parse(json[ToDoFields.colDue]),
      isDone: json[ToDoFields.colCompleted] == 1,
      hasAlert: json[ToDoFields.colAlert] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ToDoFields.colId: id,
      ToDoFields.colName: name,
      ToDoFields.colDue: due.toIso8601String(),
      ToDoFields.colAlert: hasAlert ? 1 : 0,
      ToDoFields.colCompleted: isDone ? 1 : 0,
    };
  }
}
