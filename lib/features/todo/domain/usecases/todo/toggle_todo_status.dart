import 'package:moor/moor.dart';
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/services/notification_service.dart';

import 'package:dartz/dartz.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/todos_repository.dart';
import 'add_todo.dart';

class ToggleTodoStatus implements UseCase<int, Params> {
  final TodosRepository repository;

  final NotificationService notificationService;

  ToggleTodoStatus(this.repository, this.notificationService);

  @override
  Future<Either<Failure, int>> call(Params params) {
    final TasksCompanion td = params.todo.copyWith(isDone: params.todo.isDone);
    _cancelNotification(td);
    return repository.addTodo(td);
  }

  void _cancelNotification(TasksCompanion td) {
    if (td.hasAlert.value) {
      notificationService.cancelNotification(td.id.value);
    }
  }
}
