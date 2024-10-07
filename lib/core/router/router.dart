import 'package:get/get.dart';
import 'package:vilavi_task_assistant/features/auth/presentation/pages/auth/auth_page.dart';
import 'package:vilavi_task_assistant/features/tasks/presentation/pages/task_list/task_list_page.dart';

/// Класс, содержащий маршруты приложения.
///
/// Этот класс используется для определения маршрутов и страниц,
/// доступных в приложении.
class AppRoutes {
  /// Маршрут для страницы авторизации.
  static const auth = '/auth';

  /// Маршрут для страницы списка задач.
  static const tasks = '/tasks';

  /// Список маршрутов приложения.
  ///
  /// Каждый маршрут представлен в виде [GetPage],
  /// который содержит имя маршрута и соответствующую страницу.
  static List<GetPage> routes = [
    GetPage(
      name: auth,
      page: () => const AuthPage(),
    ),
    GetPage(
      name: tasks,
      page: () => const TaskListPage(),
    ),
  ];
}