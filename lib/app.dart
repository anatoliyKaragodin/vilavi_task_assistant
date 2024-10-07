import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'core/router/router.dart';
import 'features/tasks/presentation/bloc/task_list/task_list_bloc.dart';
import 'locator.dart';

/// Основное приложение [App], которое настраивает зависимости и навигацию.
///
/// Оно использует [MultiBlocProvider] для управления состоянием через BLoC и [GetMaterialApp]
/// для навигации, предоставляемой GetX.
///
/// При инициализации загружаются задачи через [LoadTasksEvent].
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// Регистрирует [TaskListBloc], который загружает список задач при старте приложения.
        BlocProvider(
          create: (context) => get.find<TaskListBloc>()
            ..add(LoadTasksEvent()), // Загружаем задачи при инициализации блока
        ),
      ],
      /// Использует [GetMaterialApp] для настройки навигации и начальных маршрутов.
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
          useMaterial3: true,
        ),
        /// Устанавливает начальный маршрут как экран авторизации.
        initialRoute: AppRoutes.auth,

        /// Определяет маршруты приложения через [AppRoutes.routes].
        getPages: AppRoutes.routes,
      ),
    );
  }
}
