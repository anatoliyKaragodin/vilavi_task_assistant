part of 'mapper/models_mapper.dart';

/// Модель задачи.
///
/// Этот класс [TaskModel] представляет задачу в приложении и используется для
/// передачи данных между различными слоями приложения.
///
/// Параметры:
/// - [id]: уникальный идентификатор задачи.
/// - [title]: название задачи.
/// - [completed]: статус выполнения задачи (выполнена или нет).
@MappableClass(caseStyle: CaseStyle.camelCase)
class TaskModel with TaskModelMappable {
  final int id;
  final String title;
  final bool completed;

  /// Конструктор для создания экземпляра [TaskModel].
  ///
  /// Параметры:
  /// - [id]: уникальный идентификатор задачи.
  /// - [title]: название задачи.
  /// - [completed]: статус выполнения задачи.
  TaskModel({
    required this.id,
    required this.title,
    required this.completed,
  });

  /// Преобразует модель в сущность [TaskEntity].
  ///
  /// Возвращает экземпляр [TaskEntity] с соответствующими полями.
  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      title: title,
      completed: completed,
    );
  }

  /// Создаёт модель [TaskModel] на основе сущности [TaskEntity].
  ///
  /// Параметры:
  /// - [entity]: экземпляр [TaskEntity], который необходимо преобразовать в модель.
  ///
  /// Возвращает экземпляр [TaskModel] с соответствующими полями.
  static TaskModel fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      title: entity.title,
      completed: entity.completed,
    );
  }
}