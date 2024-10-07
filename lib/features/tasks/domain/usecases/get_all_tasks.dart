import 'package:dartz/dartz.dart';
import 'package:vilavi_task_assistant/features/tasks/domain/entities/mapper/entities_mapper.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/tasks_repository.dart';

/// Класс [GetAllTasks] представляет use case для получения всех задач из репозитория.
///
/// Этот класс реализует базовый [UseCase], который не принимает никаких параметров и возвращает список [TaskEntity].
/// Использует репозиторий [TaskRepository] для получения данных о задачах.
///
/// Параметры:
/// - [TaskRepository]: ссылка на репозиторий задач для взаимодействия с источником данных.
///
/// Метод [call] выполняет запрос на получение всех задач, возвращая [Either] с [Failure] в случае ошибки или [List<TaskEntity>] при успешном выполнении.
class GetAllTasks extends UseCase<List<TaskEntity>, void> {
  final TaskRepository _taskRepository;

  /// Конструктор для создания экземпляра [GetAllTasks].
  ///
  /// Параметры:
  /// - [taskRepository]: репозиторий задач, используемый для взаимодействия с данными.
  GetAllTasks(this._taskRepository);

  /// Метод для получения всех задач.
  ///
  /// Параметры:
  /// - [params]: не используется, но должен быть передан, чтобы соответствовать сигнатуре метода.
  ///
  /// Возвращает [Either] с [Failure] в случае ошибки или [List<TaskEntity>] при успешном выполнении.
  @override
  Future<Either<Failure, List<TaskEntity>>> call(void params) async {
    return await _taskRepository.getAllTasks(params);
  }
}