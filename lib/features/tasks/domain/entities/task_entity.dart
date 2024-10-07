part of 'mapper/entities_mapper.dart';

/// Класс [TaskEntity] представляет собой сущность задачи, которая используется в приложении.
///
/// Сущность содержит основные поля:
/// - [id] — уникальный идентификатор задачи.
/// - [title] — заголовок задачи.
/// - [completed] — флаг, указывающий, выполнена ли задача.
///
/// Аннотация [@MappableClass] используется для автоматической генерации маппинга,
/// который позволяет преобразовывать эту сущность в другие форматы данных, такие как JSON.
@MappableClass()
class TaskEntity with TaskEntityMappable {
  final int id;
  final String title;
  final bool completed;

  /// Конструктор [TaskEntity] требует обязательные параметры:
  /// - [id] — уникальный идентификатор задачи.
  /// - [title] — название задачи.
  /// - [completed] — статус задачи: выполнена или нет.
  TaskEntity({required this.id, required this.title, required this.completed});
}