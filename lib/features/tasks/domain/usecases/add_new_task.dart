import 'package:dartz/dartz.dart';
import 'package:vilavi_task_assistant/core/error/failure.dart';
import 'package:vilavi_task_assistant/core/usecases/usecase.dart';
import 'package:vilavi_task_assistant/features/tasks/domain/entities/mapper/entities_mapper.dart';

import '../repository/tasks_repository.dart';

/// Класс [AddNewTask] представляет use case для добавления новой задачи в репозиторий.
///
/// Этот класс реализует базовый [UseCase], который принимает объект [TaskEntity] и возвращает результат выполнения операции.
/// Использует репозиторий [TaskRepository] для выполнения операции добавления задачи.
///
/// Параметры:
/// - [TaskRepository]: ссылка на репозиторий задач для взаимодействия с источником данных.
///
/// Метод [call] выполняет добавление задачи, возвращая [Either] с [Failure] в случае ошибки или [void] при успешном выполнении.
class AddNewTask extends UseCase<void, TaskEntity> {
  final TaskRepository _taskRepository;

  /// Конструктор для создания экземпляра [AddNewTask].
  ///
  /// Параметры:
  /// - [taskRepository]: репозиторий задач, используемый для взаимодействия с данными.
  AddNewTask(this._taskRepository);

  /// Метод для добавления новой задачи.
  ///
  /// Параметры:
  /// - [params]: объект [TaskEntity], представляющий новую задачу для добавления.
  ///
  /// Возвращает [Either] с [Failure] в случае ошибки или [void] при успешном выполнении.
  @override
  Future<Either<Failure, void>> call(TaskEntity params) async {
    return await _taskRepository.addNewTask(params);
  }
}
