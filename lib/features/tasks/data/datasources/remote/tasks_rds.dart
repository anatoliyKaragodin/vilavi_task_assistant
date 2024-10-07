import 'package:vilavi_task_assistant/features/tasks/data/models/mapper/models_mapper.dart';

/// Абстрактный класс для удалённого источника данных задач.
///
/// Этот класс [TasksRDS] определяет интерфейс для получения задач из удалённого
/// хранилища, например, из веб-сервиса или API.
abstract class TasksRDS {
  /// Получает все задачи из удалённого источника данных.
  ///
  /// Возвращает список [TaskModel], представляющий все задачи,
  /// доступные в удалённом хранилище.
  Future<List<TaskModel>> getAllTasks();
}