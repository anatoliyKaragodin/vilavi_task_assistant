import 'package:vilavi_task_assistant/features/tasks/data/models/mapper/models_mapper.dart';

/// Абстрактный класс для локального источника данных задач.
///
/// Этот класс [TasksLDS] определяет методы для работы с задачами
/// в локальном хранилище, включая добавление, удаление, обновление статуса и получение всех задач.
abstract class TasksLDS {
  /// Добавляет новую задачу в локальное хранилище.
  ///
  /// Принимает объект [TaskModel], представляющий задачу.
  Future<void> addNewTask(TaskModel task);

  /// Удаляет задачу из локального хранилища по заданному идентификатору.
  ///
  /// Принимает идентификатор задачи [params] для удаления.
  Future<void> deleteTask(int params);

  /// Обновляет статус существующей задачи в локальном хранилище.
  ///
  /// Принимает объект [TaskModel], представляющий задачу с обновленным статусом.
  Future<void> updateTaskStatus(TaskModel task);

  /// Получает список всех задач из локального хранилища.
  ///
  /// Возвращает [List<TaskModel>] всех задач.
  Future<List<TaskModel>> getAllTasks();
}
