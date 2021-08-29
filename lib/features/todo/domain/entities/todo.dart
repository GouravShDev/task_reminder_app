import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../../../core/utils/constants.dart';

@Entity(tableName: kTodoTableName)
class ToDo extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final DateTime due;
  final bool isDone;
  final bool hasAlert;

  ToDo({
    this.id,
    required this.name,
    required this.due,
    this.isDone = false,
    required this.hasAlert,
  });

  @override
  List<Object> get props {
    return [
      id!,
      name,
      due,
      isDone,
      hasAlert,
    ];
  }

  ToDo copyWith({
    int? id,
    String? name,
    DateTime? due,
    bool? isDone,
    bool? hasAlert,
  }) {
    return ToDo(
      id: id ?? this.id,
      name: name ?? this.name,
      due: due ?? this.due,
      isDone: isDone ?? this.isDone,
      hasAlert: hasAlert ?? this.hasAlert,
    );
  }
}
