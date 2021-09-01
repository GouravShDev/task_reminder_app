import 'package:date_format/date_format.dart';
import '../../../../../core/services/notification_service.dart';

import '../../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/todo.dart';
import '../../repositories/todos_repository.dart';

class AddTodoToDb implements UseCase<ToDo, Params> {
  final TodosRepository repository;

  final NotificationService notificationService;
  AddTodoToDb(this.repository, this.notificationService);

  @override
  Future<Either<Failure, ToDo>> call(Params params) async {
    final result = await repository.addTodo(params.todo);
    return result.fold((failure) => Left(failure), (todo) {
      _scheduleNotification(todo);
      return Right(todo);
    });
  }

  void _scheduleNotification(ToDo td) {
    if (td.hasAlert && td.due.isAfter(DateTime.now())) {
      notificationService.scheduledNotification(
          id: td.id!,
          message: formatDate(DateTime(2019, 08, 1, td.due.hour, td.due.minute),
              [hh, ':', nn, " ", am]).toString(),
          title: td.name,
          scheduledDate: td.due);
    }
  }
}

class Params {
  final ToDo todo;

  Params(this.todo);
}
