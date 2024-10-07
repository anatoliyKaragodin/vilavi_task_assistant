import 'package:dartz/dartz.dart';
import 'package:vilavi_task_assistant/core/error/exeption.dart';
import 'package:vilavi_task_assistant/core/error/failure.dart';
import 'package:vilavi_task_assistant/features/tasks/data/datasources/local/tasks_lds.dart';
import 'package:vilavi_task_assistant/features/tasks/data/datasources/remote/tasks_rds.dart';
import 'package:vilavi_task_assistant/features/tasks/data/models/mapper/models_mapper.dart';
import 'package:vilavi_task_assistant/features/tasks/domain/entities/mapper/entities_mapper.dart';
import 'package:vilavi_task_assistant/features/tasks/domain/repository/tasks_repository.dart';

/// Реализация репозитория задач.
///
/// Этот класс [TaskRepositoryImpl] отвечает за взаимодействие с удалёнными и локальными источниками данных для
/// выполнения операций с задачами.
///
/// Параметры:
/// - [TasksLDS]: локальное хранилище задач (Local Data Source).
/// - [TasksRDS]: удалённое хранилище задач (Remote Data Source).
class TaskRepositoryImpl implements TaskRepository {
  final TasksLDS _tasksLDS;
  final TasksRDS _tasksRDS;

  /// Конструктор для создания экземпляра [TaskRepositoryImpl].
  ///
  /// Параметры:
  /// - [tasksLDS]: локальное хранилище задач.
  /// - [tasksRDS]: удалённое хранилище задач.
  TaskRepositoryImpl(this._tasksLDS, this._tasksRDS);

  /// Добавляет новую задачу в локальное хранилище.
  ///
  /// Параметры:
  /// - [params]: экземпляр [TaskEntity], представляющий новую задачу.
  ///
  /// Возвращает [Either] с [Failure] в случае ошибки или `void` при успешном выполнении.
  @override
  Future<Either<Failure, void>> addNewTask(TaskEntity params) async {
    try {
      await _tasksLDS.addNewTask(TaskModel.fromEntity(params));
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  /// Удаляет задачу по идентификатору из локального хранилища.
  ///
  /// Параметры:
  /// - [params]: идентификатор задачи для удаления.
  ///
  /// Возвращает [Either] с [Failure] в случае ошибки или `void` при успешном выполнении.
  @override
  Future<Either<Failure, void>> deleteTask(int params) async {
    try {
      await _tasksLDS.deleteTask(params);
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  /// Получает все задачи из удалённого и локального хранилищ.
  ///
  /// Параметры:
  /// - [params]: неиспользуемый параметр.
  ///
  /// Возвращает [Either] с [Failure] в случае ошибки или список [TaskEntity] при успешном выполнении.
  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTasks(void params) async {
    try {
      // Получаем задачи с сервера
      final remoteTasks = await _tasksRDS.getAllTasks();

      // Получаем задачи из локального хранилища
      final localTasks = await _tasksLDS.getAllTasks();

      // Объединяем списки с приоритетом локальных задач
      final combinedTasks = _mergeTasks(remoteTasks, localTasks)
          .map((e) => e.toEntity())
          .toList();

      // Возвращаем объединённый список задач
      return Right(combinedTasks);
    } on ServerException {
      // В случае ошибки сервера, возвращаем ServerFailure
      return Left(ServerFailure());
    } catch (e) {
      // Если произошла другая ошибка, возвращаем CacheFailure
      return Left(CacheFailure());
    }
  }

  /// Обновляет статус задачи в локальном хранилище.
  ///
  /// Параметры:
  /// - [params]: экземпляр [TaskEntity] с обновленным статусом.
  ///
  /// Возвращает [Either] с [Failure] в случае ошибки или `void` при успешном выполнении.
  @override
  Future<Either<Failure, void>> updateTaskStatus(TaskEntity params) async {
    try {
      await _tasksLDS.updateTaskStatus(TaskModel.fromEntity(params));
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  // Приватные методы здесь

  /// Объединяет задачи с приоритетом локальных данных.
  ///
  /// Параметры:
  /// - [remoteTasks]: список удалённых задач.
  /// - [localTasks]: список локальных задач.
  ///
  /// Возвращает список объединённых задач [TaskModel].
  List<TaskModel> _mergeTasks(
      List<TaskModel> remoteTasks, List<TaskModel> localTasks) {
    // Используем Map для того, чтобы при совпадении id оставлять локальную задачу
    final Map<int, TaskModel> taskMap = {
      for (var task in remoteTasks) task.id: task,
    };

    // Обновляем или добавляем задачи из локального хранилища
    for (var localTask in localTasks) {
      taskMap[localTask.id] = localTask;
    }

    // Возвращаем объединённый список задач
    return taskMap.values.toList();
  }
}