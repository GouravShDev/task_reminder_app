import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'task_list.dart';

import '../../../../core/utils/constants.dart';

@Entity(tableName: kTodoTableName)
class ToDo extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final DateTime due;
  final bool isDone;
  final bool hasAlert;
  final int repeatMode;
  @ForeignKey(childColumns: [
    kTaskColId,
    kTaskColName,
    kTaskColDue,
    kTaskColCompleted,
    kTaskColAlert,
    kTaskColRepeatMode,
    kTaskColTaskListId,
  ], parentColumns: [
    'id',
    'name'
  ], entity: TaskList)
  final int taskListId;

  ToDo({
    this.id,
    required this.name,
    required this.due,
    this.isDone = false,
    required this.hasAlert,
    this.repeatMode = 0,
    this.taskListId = 0,
  });

  @override
  List<Object> get props {
    return [
      id!,
      name,
      due,
      isDone,
      hasAlert,
      repeatMode,
      taskListId,
    ];
  }

  ToDo copyWith({
    int? id,
    String? name,
    DateTime? due,
    bool? isDone,
    bool? hasAlert,
    int? repeatMode,
    int? taskListId,
  }) {
    return ToDo(
      id: id ?? this.id,
      name: name ?? this.name,
      due: due ?? this.due,
      isDone: isDone ?? this.isDone,
      hasAlert: hasAlert ?? this.hasAlert,
      repeatMode: repeatMode ?? this.repeatMode,
      taskListId: taskListId ?? this.taskListId,
    );
  }
}
