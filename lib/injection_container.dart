import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/utils/todo_filter.dart';
import 'package:todo_list/features/todo/domain/repositories/task_list_repository.dart';
import 'package:todo_list/features/todo/domain/usecases/taskList/add_task_list.dart';
import 'package:todo_list/features/todo/domain/usecases/taskList/delete_task_list.dart';
import 'package:todo_list/features/todo/domain/usecases/taskList/watch_task_list.dart';
import 'features/todo/data/repositories/task_list_repository_impl.dart';
import 'features/todo/domain/usecases/taskList/get_task_list.dart';
import 'features/todo/domain/usecases/todo/toggle_todo_status.dart';
import 'features/todo/domain/usecases/todo/watch_incomp_todo_list.dart';
import 'features/todo/presentation/blocs/taskList_bloc/task_list_bloc.dart';
import 'core/services/notification_service.dart';
import 'core/utils/date_formatter.dart';
import 'features/settings/provider/settings_provider.dart';
// import 'features/settings/theme/bloc/theme_bloc.dart';
import 'features/todo/data/datasources/local/database/app_database.dart';
import 'features/todo/data/datasources/local/todo_database_data_source.dart';
import 'features/todo/data/repositories/todos_repository_impl.dart';
import 'features/todo/domain/repositories/todos_repository.dart';
import 'features/todo/domain/usecases/todo/add_todo.dart';
import 'features/todo/domain/usecases/todo/get_todo_list.dart';
import 'features/todo/presentation/blocs/todo_bloc/todo_bloc.dart';

final locator = GetIt.I;

void init() {
  // ! Features - Todo
  // ? bloc
  locator.registerFactory<TodoBloc>(() => TodoBloc(
      getTodosList: locator(),
      addTodoToDb: locator(),
      toggleTodoStatus: locator(),
      watchIncompTodoList: locator()));
  locator.registerFactory<TaskListBloc>(() => TaskListBloc(
        getAllTaskList: locator(),
        watchTasksList: locator(),
        addTaskList: locator(),
        deleteTaskList: locator(),
      ));

  // locator.registerFactory<ThemeBloc>(() => ThemeBloc(locator()));

  // ? UseCases
  // Todo
  locator.registerLazySingleton<GetTodosList>(() => GetTodosList(locator()));
  locator.registerLazySingleton<AddTodoToDb>(
      () => AddTodoToDb(locator(), locator()));
  locator.registerLazySingleton<ToggleTodoStatus>(
      () => ToggleTodoStatus(locator(), locator()));
  locator.registerLazySingleton<WatchIncompTodoList>(
      () => WatchIncompTodoList(locator()));

  // TaskList
  locator
      .registerLazySingleton<GetAllTaskList>(() => GetAllTaskList(locator()));
  locator
      .registerLazySingleton<WatchTasksList>(() => WatchTasksList(locator()));
  locator.registerLazySingleton<AddTaskList>(() => AddTaskList(locator()));
  locator
      .registerLazySingleton<DeleteTaskList>(() => DeleteTaskList(locator()));

  // ? Repositories
  locator.registerLazySingleton<TodosRepository>(
      () => TodoRepositoryImpl(databaseDataSource: locator()));
  locator.registerLazySingleton<TaskListRepository>(
      () => TaskListRepositoryImpl(databaseDataSource: locator()));

  // ? DataSources
  locator.registerLazySingleton<TodoDatabaseDataSource>(
      () => TodoDatabaseSourceImpl(locator()));

  // ! Core
  // ? Utils
  locator.registerLazySingleton<DateFormatter>(() => DateFormatter());

  locator.registerLazySingleton<TodoFilter>(() => TodoFilter());

  // ? Services

  locator.registerSingletonAsync<FlutterLocalNotificationsPlugin>(() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    final InitializationSettings initializationSettings =
        new InitializationSettings(
      android: AndroidInitializationSettings('ic_app_logo'),
      iOS: IOSInitializationSettings(),
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
    return flutterLocalNotificationsPlugin;
  });

  locator.registerLazySingleton<NotificationService>(
      () => NotificationServiceImp(locator()));

  // ! External
  // ? Database
  locator.registerSingleton<AppDatabase>(AppDatabase());
  // locator.registerSingletonAsync<AppDatabase>(() async {
  //   final db = $FloorAppDatabase
  //       .databaseBuilder(kDatabaseName)
  //       .addMigrations([
  //         Migration(1, 2, (db) async {
  //           await db.execute(
  //               '''CREATE TABLE IF NOT EXISTS `temp` (`id` INTEGER PRIMARY KEY AUTOINCREMENT,
  //               `name` TEXT NOT NULL, `due` TEXT NOT NULL,
  //                `isDone` INTEGER NOT NULL,
  //                `hasAlert` INTEGER NOT NULL,
  //                `repeatMode` INTEGER NOT NULL DEFAULT 0,
  //                `taskListId` INTEGER NOT NULL DEFAULT 0),
  //                "FOREIGN KEY (taskListId) REFERENCES $kTaskListTableName (id) ON DELETE NO ACTION ON UPDATE NO ACTION,''');
  //           await db.execute(
  //               'INSERT INTO temp (id, name, due, isDone, hasAlert) SELECT * FROM tasks;');
  //           await db.execute('DROP TABLE tasks;');
  //           await db.execute('ALTER TABLE temp RENAME TO tasks');
  //         })
  //       ])
  //       .addCallback(Callback(onOpen: (db) async {
  //         db.execute('PRAGMA foreign_keys = ON');
  //       }, onCreate: (database, version) {
  //         database.execute(
  //             'INSERT INTO $kTaskListTableName (id, name) VALUES (0, "Default");');
  //         database.execute(
  //             'INSERT INTO $kTaskListTableName (id, name) VALUES (1, "Personal");');
  //         database.execute(
  //             'INSERT INTO $kTaskListTableName (id, name) VALUES (2, "Work");');
  //       }))
  //       .build();
  //   return db;
  // });

  // ! Features - Settings

  // ! Provider
  // ? Settings
  locator.registerLazySingleton<Settings>(() => Settings(locator()));

  // ! External
  // ? SharedPreferences
  locator.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());
}
