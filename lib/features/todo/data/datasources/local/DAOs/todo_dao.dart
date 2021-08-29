import 'package:floor/floor.dart';
import '../../../../domain/entities/todo.dart';
import '../../../../../../core/utils/constants.dart';

@dao
abstract class TodoDao {
  @Query('SELECT * FROM $kTodoTableName ORDER BY due ASC')
  Future<List<ToDo>> getAllTodos();

  @Query('SELECT * FROM $kTodoTableName WHERE id = :id')
  Future<ToDo?> getTodoById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertTodo(ToDo todo);

  @delete
  Future<void> deleteTodo(ToDo todo);
}
