import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/settings/theme/app_themes.dart';
import 'features/settings/provider/settings_provider.dart';
import 'features/todo/presentation/pages/todo_overview_page.dart';
import 'injection_container.dart' as injector;
import 'package:provider/provider.dart';

import 'router/app_router.dart';

import 'features/todo/presentation/bloc/todo_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  injector.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();
  late Future<void> _initDependencies;

  @override
  void initState() {
    _initDependencies = injector.locator.allReady();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return FutureBuilder(
      future: _initDependencies,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Provider<Settings>(
            create: (context) => injector.locator<Settings>(),
            builder: (context, _) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => injector.locator<TodoBloc>(),
                  ),
                  // BlocProvider(
                  //   create: (context) => injector.locator<ThemeBloc>(),
                  // ),
                ],
                child: ValueListenableBuilder<AppTheme>(
                  valueListenable: Provider.of<Settings>(context).appTheme,
                  builder: (context, value, _) {
                    return MaterialApp(
                      title: 'ToDo List',
                      theme: appThemeData[value],
                      onGenerateRoute: _appRouter.onGenerateRoute,
                      home: TodoOverviewPage(),
                    );
                  },
                )),
          );
          // )
          // return BlocProvider(
          //   create: (context) => injector.locator<TodoBloc>(),
          //   child: MaterialApp(
          //     title: 'ToDo List',
          //     theme: ThemeData(
          //       primarySwatch: Colors.blue,
          //     ),
          //     onGenerateRoute: _appRouter.onGenerateRoute,
          //     home: TodoOverviewPage(),
          //   ),
          // );
        } else {
          // ToDo: Add loading screen
          return Container();
        }
      },
    );
  }
}
