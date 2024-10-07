part of 'task_list_bloc.dart';

/// Часть блока [TaskListBloc], описывающая события, связанные с задачами.
///
/// Эти события используются для обработки действий пользователя, таких как
/// загрузка задач, добавление новой задачи, удаление задачи, обновление
/// статуса задачи и фильтрация списка задач.

/// Перечисление [TaskFilter] определяет фильтры для отображения задач.
///
/// [TaskFilter.all] - отображает все задачи.
/// [TaskFilter.completed] - отображает только выполненные задачи.
/// [TaskFilter.incomplete] - отображает только невыполненные задачи.
enum TaskFilter { all, completed, incomplete }

/// Абстрактный класс [TaskListEvent] является базовым для всех событий, связанных
/// с задачами в блоке [TaskListBloc].
///
/// Этот класс наследуется всеми специфическими событиями и используется для их
/// унифицированной обработки.
abstract class TaskListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Событие [LoadTasksEvent] инициирует загрузку всех задач при запуске приложения.
class LoadTasksEvent extends TaskListEvent {}

/// Событие [AddTaskEvent] добавляет новую задачу в список задач.
///
/// Принимает [title] в качестве параметра, который используется для создания
/// новой задачи.
class AddTaskEvent extends TaskListEvent {
  final String title;

  AddTaskEvent(this.title);

  @override
  List<Object> get props => [title];
}

/// Событие [DeleteTaskEvent] удаляет задачу из списка по её [id].
///
/// Принимает [id] в качестве параметра для идентификации задачи, которая
/// должна быть удалена.
class DeleteTaskEvent extends TaskListEvent {
  final int id;

  DeleteTaskEvent(this.id);

  @override
  List<Object> get props => [id];
}

/// Событие [UpdateTaskStatusEvent] обновляет статус задачи.
///
/// Принимает объект [TaskEntity], представляющий задачу, статус которой
/// будет обновлён.
class UpdateTaskStatusEvent extends TaskListEvent {
  final TaskEntity task;

  UpdateTaskStatusEvent(this.task);

  @override
  List<Object> get props => [task];
}

/// Событие [FilterTasksEvent] применяется для фильтрации списка задач.
///
/// Принимает [filter], который определяет, какие задачи будут отображаться
/// в зависимости от их статуса.
class FilterTasksEvent extends TaskListEvent {
  final TaskFilter filter;

  FilterTasksEvent(this.filter);

  @override
  List<Object> get props => [filter];
}