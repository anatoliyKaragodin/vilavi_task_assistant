import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vilavi_task_assistant/features/tasks/data/datasources/local/tasks_lds.dart';
import 'package:vilavi_task_assistant/features/tasks/data/datasources/local/tasks_lds_impl.dart';
import 'package:vilavi_task_assistant/features/tasks/data/datasources/remote/tasks_rds.dart';
import 'package:vilavi_task_assistant/features/tasks/data/datasources/remote/tasks_rds_impl.dart';
import 'package:vilavi_task_assistant/features/tasks/domain/repository/tasks_repository.dart';

import 'features/tasks/data/repository/task_pepository_impl.dart';
import 'features/tasks/domain/usecases/add_new_task.dart';
import 'features/tasks/domain/usecases/delete_task.dart';
import 'features/tasks/domain/usecases/get_all_tasks.dart';
import 'features/tasks/domain/usecases/updateTaskStatus.dart';
import 'features/tasks/presentation/bloc/task_list/task_list_bloc.dart';

/// Используется для управления зависимостями через GetX.
final get = Get;

/// Настраивает локатор зависимостей для приложения.
///
/// Эта функция регистрирует все необходимые зависимости, включая
/// источники данных, репозитории, use cases и BLoC для управления
/// состоянием приложения.
Future<void> setupLocator() async {
  // Создает экземпляр Dio для работы с HTTP-запросами.
  final dio = Dio();

  // Получает экземпляр SharedPreferences для локального хранения.
  final sharedPref = await SharedPreferences.getInstance();

  // Регистрация источника данных
  get.lazyPut<TasksLDS>(() => TasksLDSImpl(sharedPref));

  get.lazyPut<TasksRDS>(() => TasksRDSImpl(dio));

  // Регистрация репозитория
  get.lazyPut<TaskRepository>(() => TaskRepositoryImpl(get.find(), get.find()));

  // Регистрация use cases
  get.lazyPut(() => GetAllTasks(get.find()));
  get.lazyPut(() => AddNewTask(get.find()));
  get.lazyPut(() => UpdateTaskStatus(get.find()));
  get.lazyPut(() => DeleteTask(get.find()));

  // Регистрация BLoC
  get.lazyPut<TaskListBloc>(() => TaskListBloc(
    get.find(),
    get.find(),
    get.find(),
    get.find(),
  ));
}
