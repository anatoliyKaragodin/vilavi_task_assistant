import 'package:dartz/dartz.dart';
import 'package:vilavi_task_assistant/core/error/failure.dart';
import 'package:vilavi_task_assistant/features/tasks/domain/entities/mapper/entities_mapper.dart';

/// Абстрактный класс [TaskRepository] представляет интерфейс для взаимодействия с репозиторием задач.
///
/// Этот интерфейс определяет методы для выполнения CRUD операций над сущностями задач:
/// - Добавление новой задачи: [addNewTask].
/// - Удаление задачи: [deleteTask].
/// - Получение всех задач: [getAllTasks].
/// - Обновление статуса задачи: [updateTaskStatus].
///
/// Каждая операция возвращает результат в виде объекта [Either], который может содержать либо успешный результат,
/// либо ошибку типа [Failure], что позволяет удобно обрабатывать возможные ошибки.
abstract class TaskRepository {

  /// Добавляет новую задачу в репозиторий.
  ///
  /// Параметры:
  /// - [params]: объект [TaskEntity], представляющий новую задачу.
  ///
  /// Возвращает [Either] с [Failure] в случае ошибки, либо [void] при успешном выполнении.
  Future<Either<Failure, void>> addNewTask(TaskEntity params);

  /// Удаляет задачу по её [id].
  ///
  /// Параметры:
  /// - [params]: идентификатор задачи, которую нужно удалить.
  ///
  /// Возвращает [Either] с [Failure] в случае ошибки, либо [void] при успешном выполнении.
  Future<Either<Failure, void>> deleteTask(int params);

  /// Получает список всех задач.
  ///
  /// Параметры:
  /// - [params]: принимает [void], так как дополнительных параметров не требуется.
  ///
  /// Возвращает [Either] с [Failure] в случае ошибки, либо список [List<TaskEntity>] при успешном выполнении.
  Future<Either<Failure, List<TaskEntity>>> getAllTasks(void params);

  /// Обновляет статус существующей задачи.
  ///
  /// Параметры:
  /// - [params]: объект [TaskEntity], представляющий задачу с обновлённым статусом.
  ///
  /// Возвращает [Either] с [Failure] в случае ошибки, либо [void] при успешном выполнении.
  Future<Either<Failure, void>> updateTaskStatus(TaskEntity params);
}
