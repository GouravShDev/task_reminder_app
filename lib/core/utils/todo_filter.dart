import 'constants.dart';
import '../../features/todo/domain/entities/todo.dart';

class TodoFilter {
  List<ToDo> filterTodos(List<ToDo> list, String listType) {
    final now = DateTime.now();
    // final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    switch (listType) {
      case kTodayTodo:
        return list
            .where(
                (todo) => todo.due.isAfter(now) && todo.due.isBefore(tomorrow))
            .toList();
      case kOverdueTodo:
        return list.where((todo) => todo.due.isBefore(now)).toList();
      case kUpcomingTodo:
        return list.where((todo) => todo.due.isAfter(tomorrow)).toList();
      default:
        return list;
    }
  }
}
