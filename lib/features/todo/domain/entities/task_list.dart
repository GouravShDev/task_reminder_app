import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../../../core/utils/constants.dart';

@Entity(tableName: kTaskListTableName)
class TaskList extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;

  TaskList({
    this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [name];

  TaskList copyWith({
    int? id,
    String? name,
  }) {
    return TaskList(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
