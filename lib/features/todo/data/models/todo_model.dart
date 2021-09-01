import '../../../../core/utils/constants.dart';

import '../../domain/entities/todo.dart';

class ToDoModel extends ToDo {
  ToDoModel({
    required id,
    required name,
    required due,
    required isDone,
    required hasAlert,
    required repeatMode,
    required taskListId,
  }) : super(
          id: id,
          name: name,
          due: due,
          isDone: isDone,
          hasAlert: hasAlert,
          repeatMode: repeatMode,
          taskListId: taskListId,
        );

  factory ToDoModel.fromDatabaseJson(Map<String, dynamic> json) {
    return ToDoModel(
      id: json[kTaskColId],
      name: json[kTaskColName],
      due: DateTime.parse(json[kTaskColDue]),
      isDone: json[kTaskColCompleted] == 1,
      hasAlert: json[kTaskColAlert] == 1,
      repeatMode: json[kTaskColRepeatMode],
      taskListId: json[kTaskColTaskListId],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kTaskColId: id,
      kTaskColName: name,
      kTaskColDue: due.toIso8601String(),
      kTaskColAlert: hasAlert ? 1 : 0,
      kTaskColCompleted: isDone ? 1 : 0,
      kTaskColRepeatMode: repeatMode,
      kTaskColTaskListId: taskListId,
    };
  }
}
