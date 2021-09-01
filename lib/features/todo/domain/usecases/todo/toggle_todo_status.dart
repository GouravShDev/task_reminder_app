import '../../../../../core/error/failures.dart';
import '../../../../../core/services/notification_service.dart';

import 'package:dartz/dartz.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/todo.dart';
import '../../repositories/todos_repository.dart';
import 'add_todo.dart';

class ToggleTodoStatus implements UseCase<ToDo, Params> {
  final TodosRepository repository;

  final NotificationService notificationService;

  ToggleTodoStatus(this.repository, this.notificationService);

  @override
  Future<Either<Failure, ToDo>> call(Params params) {
    final ToDo td = params.todo.copyWith(isDone: !params.todo.isDone);
    _cancelNotification(td);
    return repository.addTodo(td);
  }

  void _cancelNotification(ToDo td) {
    if (td.hasAlert) {
      notificationService.cancelNotification(td.id!);
    }
  }
}
