import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/tasks_repository.dart';

/// Класс [DeleteTask] представляет use case для удаления задачи из репозитория.
///
/// Этот класс реализует базовый [UseCase], который принимает [int] (идентификатор задачи) и возвращает результат выполнения операции.
/// Использует репозиторий [TaskRepository] для выполнения операции удаления задачи.
///
/// Параметры:
/// - [TaskRepository]: ссылка на репозиторий задач для взаимодействия с источником данных.
///
/// Метод [call] выполняет удаление задачи, возвращая [Either] с [Failure] в случае ошибки или [void] при успешном выполнении.
class DeleteTask extends UseCase<void, int> {
  final TaskRepository _taskRepository;

  /// Конструктор для создания экземпляра [DeleteTask].
  ///
  /// Параметры:
  /// - [taskRepository]: репозиторий задач, используемый для взаимодействия с данными.
  DeleteTask(this._taskRepository);

  /// Метод для удаления задачи.
  ///
  /// Параметры:
  /// - [params]: идентификатор задачи, которую нужно удалить.
  ///
  /// Возвращает [Either] с [Failure] в случае ошибки или [void] при успешном выполнении.
  @override
  Future<Either<Failure, void>> call(int params) async {
    return await _taskRepository.deleteTask(params);
  }
}