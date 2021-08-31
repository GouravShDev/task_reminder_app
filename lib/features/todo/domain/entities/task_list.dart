import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:todo_list/core/utils/constants.dart';

@Entity(tableName: kTaskListTableName)
class TaskList extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;

  TaskList({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [name];
}
