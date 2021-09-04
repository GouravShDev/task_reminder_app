import 'package:flutter/material.dart';
import '../features/todo/data/datasources/local/database/app_database.dart';
import '../features/todo/presentation/pages/task_list_page.dart';
import '../features/settings/ui/pages/Settings_page.dart';
import '../features/todo/presentation/pages/todo_add_edit_page.dart';
import '../features/todo/presentation/pages/todo_overview_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case TodoOverviewPage.route:
        return MaterialPageRoute(
          builder: (context) => TodoOverviewPage(),
        );
      case TodoAddEditPage.route:
        if (routeSettings.arguments == null) {
          return MaterialPageRoute(
            builder: (context) => TodoAddEditPage(),
          );
        } else {
          final Todo todo = routeSettings.arguments as Todo;
          return MaterialPageRoute(
            builder: (context) => TodoAddEditPage(
              currentTodo: todo,
            ),
          );
        }
      case SettingsPage.route:
        return MaterialPageRoute(
          builder: (context) => SettingsPage(),
        );
      case TaskListPage.route:
        return MaterialPageRoute(
          builder: (context) => TaskListPage(),
        );
      default:
        return null;
    }
  }
}
