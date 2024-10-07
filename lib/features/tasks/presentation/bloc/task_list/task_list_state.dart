part of 'task_list_bloc.dart';

/// Абстрактный класс [TaskListState] представляет состояния блока [TaskListBloc].
///
/// Это базовый класс для всех состояний, которые могут возникнуть при работе с задачами.
/// Все конкретные состояния наследуют от этого класса.
abstract class TaskListState extends Equatable {
  @override
  List<Object> get props => [];
}

/// Состояние [TaskInitial] указывает на начальное состояние блока.
///
/// Это состояние используется до загрузки или выполнения каких-либо действий с задачами.
class TaskInitial extends TaskListState {}

/// Состояние [TaskLoading] указывает, что задачи находятся в процессе загрузки.
///
/// Это состояние отображается, когда приложение делает запрос на получение списка задач.
class TaskLoading extends TaskListState {}

/// Состояние [TaskLoaded] содержит список задач и отфильтрованных задач.
///
/// [tasks] - это полный список задач, загруженных из репозитория.
/// [filteredTasks] - это отфильтрованный список задач, отображаемый в интерфейсе.
/// Если [filteredTasks] не передан, то он по умолчанию равен [tasks].
class TaskLoaded extends TaskListState {
  final List<TaskEntity> tasks;
  final List<TaskEntity> filteredTasks;

  TaskLoaded({required this.tasks, List<TaskEntity>? filteredTasks})
      : filteredTasks = filteredTasks ?? tasks;

  @override
  List<Object> get props => [tasks, filteredTasks];
}

/// Состояние [TaskError] указывает на возникновение ошибки при выполнении действий с задачами.
///
/// Это состояние используется для отображения ошибки, если что-то пошло не так при загрузке,
/// добавлении, удалении или обновлении задач. Содержит строковое сообщение [message].
class TaskError extends TaskListState {
  final String message;

  TaskError({required this.message});

  @override
  List<Object> get props => [message];
}