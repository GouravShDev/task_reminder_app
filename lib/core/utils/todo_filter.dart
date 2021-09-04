import '../../features/todo/data/datasources/local/database/app_database.dart';
import 'constants.dart';

class TodoFilter {
  List<TodoWithTasksList> filterTodos(
      List<TodoWithTasksList> list, String listType) {
    final now = DateTime.now();
    // final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    switch (listType) {
      case kTodayTodo:
        return list
            .where((todoWithTl) =>
                todoWithTl.todo.due!.isAfter(now) &&
                todoWithTl.todo.due!.isBefore(tomorrow))
            .toList();
      case kOverdueTodo:
        return list
            .where((tdWithTl) => tdWithTl.todo.due!.isBefore(now))
            .toList();
      case kUpcomingTodo:
        return list
            .where((tdWithTl) => tdWithTl.todo.due!.isAfter(tomorrow))
            .toList();
      default:
        return list;
    }
  }
}
