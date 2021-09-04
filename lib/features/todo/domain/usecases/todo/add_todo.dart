import 'package:date_format/date_format.dart';
import 'package:moor/moor.dart';
import 'package:todo_list/features/todo/data/datasources/local/database/app_database.dart';
import '../../../../../core/services/notification_service.dart';

import '../../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/todos_repository.dart';

class AddTodoToDb implements UseCase<int, TodoParams> {
  final TodosRepository repository;

  final NotificationService notificationService;
  AddTodoToDb(this.repository, this.notificationService);

  @override
  Future<Either<Failure, int>> call(TodoParams params) async {
    final result = await repository.addTodo(params.todo);
    return result.fold((failure) => Left(failure), (id) {
      _scheduleNotification(id, params.todo);
      return Right(id);
    });
  }

  void _scheduleNotification(int id, TasksCompanion td) {
    if (td.due != Value.absent() &&
        td.hasAlert.value &&
        td.due.value!.isAfter(DateTime.now())) {
      final time = td.due.value!;
      notificationService.scheduledNotification(
          id: id,
          message: formatDate(DateTime(2019, 08, 1, time.hour, time.minute),
              [hh, ':', nn, " ", am]).toString(),
          title: td.name.value,
          scheduledDate: time);
    }
  }
}

class TodoParams {
  final TasksCompanion todo;

  TodoParams(this.todo);
}
