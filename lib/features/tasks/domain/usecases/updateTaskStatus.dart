import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/mapper/entities_mapper.dart';
import '../repository/tasks_repository.dart';

/// Класс [UpdateTaskStatus] представляет use case для обновления статуса задачи.
///
/// Этот класс реализует базовый [UseCase], который принимает [TaskEntity] в качестве параметра и возвращает `void`.
/// Использует репозиторий [TaskRepository] для обновления статуса задачи.
///
/// Параметры:
/// - [TaskRepository]: ссылка на репозиторий задач для взаимодействия с источником данных.
///
/// Метод [call] выполняет запрос на обновление статуса задачи, возвращая [Either] с [Failure] в случае ошибки или `void` при успешном выполнении.
class UpdateTaskStatus extends UseCase<void, TaskEntity> {
  final TaskRepository _taskRepository;

  /// Конструктор для создания экземпляра [UpdateTaskStatus].
  ///
  /// Параметры:
  /// - [taskRepository]: репозиторий задач, используемый для взаимодействия с данными.
  UpdateTaskStatus(this._taskRepository);

  /// Метод для обновления статуса задачи.
  ///
  /// Параметры:
  /// - [params]: экземпляр [TaskEntity], представляющий задачу с обновленным статусом.
  ///
  /// Возвращает [Either] с [Failure] в случае ошибки или `void` при успешном выполнении.
  @override
  Future<Either<Failure, void>> call(TaskEntity params) async {
    return await _taskRepository.updateTaskStatus(params);
  }
}