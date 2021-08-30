import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'core/services/notification_service.dart';
import 'core/utils/constants.dart';
import 'core/utils/date_formatter.dart';
import 'core/utils/todo_filter.dart';
import 'features/settings/provider/settings_provider.dart';
// import 'features/settings/theme/bloc/theme_bloc.dart';
import 'features/todo/data/datasources/local/database/app_database.dart';
import 'features/todo/data/datasources/local/todo_database_data_source.dart';
import 'features/todo/data/repositories/todos_repository_impl.dart';
import 'features/todo/domain/repositories/todos_repository.dart';
import 'features/todo/domain/usecases/add_todo.dart';
import 'features/todo/domain/usecases/get_todo_list.dart';
import 'features/todo/domain/usecases/toggle_todo_status.dart';
import 'features/todo/presentation/bloc/todo_bloc.dart';

final locator = GetIt.I;

void init() {
  // ! Features - Todo
  // ? bloc
  locator.registerFactory<TodoBloc>(() => TodoBloc(
      getTodosList: locator(),
      addTodoToDb: locator(),
      toggleTodoStatus: locator(),
      notificationService: locator()));

  // locator.registerFactory<ThemeBloc>(() => ThemeBloc(locator()));

  // ? UseCases
  locator.registerLazySingleton<GetTodosList>(() => GetTodosList(locator()));
  locator.registerLazySingleton<AddTodoToDb>(() => AddTodoToDb(locator()));
  locator.registerLazySingleton<ToggleTodoStatus>(
      () => ToggleTodoStatus(locator()));

  // ? Repositories
  locator.registerLazySingleton<TodosRepository>(
      () => TodoRepositoryImpl(databaseDataSource: locator()));

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
  locator.registerSingletonAsync<AppDatabase>(
      () async => $FloorAppDatabase.databaseBuilder(kDatabaseName).build());

  // ! Features - Settings

  // ! Provider
  // ? Settings
  locator.registerLazySingleton<Settings>(() => Settings(locator()));

  // ! External
  // ? SharedPreferences
  locator.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());
}
