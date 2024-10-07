import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vilavi_task_assistant/features/tasks/domain/entities/mapper/entities_mapper.dart';

import '../../../domain/usecases/add_new_task.dart';
import '../../../domain/usecases/delete_task.dart';
import '../../../domain/usecases/get_all_tasks.dart';
import '../../../domain/usecases/updateTaskStatus.dart';

part 'task_list_event.dart';
part 'task_list_state.dart';

/// [TaskListBloc] - это BLoC (Business Logic Component), который управляет
/// состояниями и событиями для работы с задачами.
///
/// Он включает в себя операции загрузки, добавления, удаления и обновления статусов задач.
/// Использует соответствующие use cases для взаимодействия с репозиторием данных.
class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final AddNewTask _addNewTask;
  final GetAllTasks _getAllTasks;
  final DeleteTask _deleteTask;
  final UpdateTaskStatus _updateTaskStatus;

  /// Конструктор [TaskListBloc] принимает use cases для работы с задачами.
  ///
  /// Начальное состояние [TaskInitial], которое затем изменяется на основе полученных событий.
  TaskListBloc(
    this._addNewTask,
    this._getAllTasks,
    this._deleteTask,
    this._updateTaskStatus,
  ) : super(TaskInitial()) {
    /// Обработчик для события [LoadTasksEvent].
    ///
    /// Загружает список задач с использованием [GetAllTasks] use case.
    /// В случае успеха загружает задачи в состояние [TaskLoaded],
    /// а в случае ошибки - в состояние [TaskError].
    on<LoadTasksEvent>((event, emit) async {
      emit(TaskLoading());
      final result = await _getAllTasks(null);
      result.fold(
        (failure) => emit(TaskError(message: 'Ошибка загрузки задач')),
        (tasks) => emit(TaskLoaded(tasks: tasks)),
      );
    });

    /// Обработчик для события [AddTaskEvent].
    ///
    /// Добавляет новую задачу в репозиторий с использованием [AddNewTask] use case.
    /// После успешного добавления обновляет список задач в состоянии [TaskLoaded].
    on<AddTaskEvent>((event, emit) async {
      if (state is TaskLoaded) {
        final loadedState = state as TaskLoaded;

        int newId =
            loadedState.tasks.isNotEmpty ? loadedState.tasks.last.id + 1 : 0;
        final newTask =
            TaskEntity(id: newId, title: event.title, completed: false);

        final result = await _addNewTask(newTask);
        result.fold(
          (failure) => emit(TaskError(message: 'Ошибка добавления задачи')),
          (success) {
            final updatedTasks = List<TaskEntity>.from(loadedState.tasks)
              ..add(newTask);
            emit(TaskLoaded(tasks: updatedTasks, filteredTasks: updatedTasks));
          },
        );
      }
    });

    /// Обработчик для события [DeleteTaskEvent].
    ///
    /// Удаляет задачу из репозитория с использованием [DeleteTask] use case.
    /// После успешного удаления обновляет список задач в состоянии [TaskLoaded].
    on<DeleteTaskEvent>((event, emit) async {
      if (state is TaskLoaded) {
        final loadedState = state as TaskLoaded;

        final result = await _deleteTask(event.id);
        result.fold(
          (failure) => emit(TaskError(message: 'Ошибка удаления задачи')),
          (success) {
            final updatedTasks =
                loadedState.tasks.where((task) => task.id != event.id).toList();
            emit(TaskLoaded(tasks: updatedTasks, filteredTasks: updatedTasks));
          },
        );
      }
    });

    /// Обработчик для события [UpdateTaskStatusEvent].
    ///
    /// Обновляет статус задачи с использованием [UpdateTaskStatus] use case.
    /// После успешного обновления обновляет список задач в состоянии [TaskLoaded].
    on<UpdateTaskStatusEvent>((event, emit) async {
      if (state is TaskLoaded) {
        final loadedState = state as TaskLoaded;

        final result = await _updateTaskStatus(event.task);
        result.fold(
          (failure) =>
              emit(TaskError(message: 'Ошибка обновления статуса задачи')),
          (success) {
            final updatedTasks = loadedState.tasks.map((task) {
              return task.id == event.task.id ? event.task : task;
            }).toList();
            emit(TaskLoaded(tasks: updatedTasks, filteredTasks: updatedTasks));
          },
        );
      }
    });

    /// Обработчик для события [FilterTasksEvent].
    ///
    /// Фильтрует задачи в зависимости от выбранного фильтра:
    /// [TaskFilter.all] - показывает все задачи,
    /// [TaskFilter.completed] - показывает только выполненные задачи,
    /// [TaskFilter.incomplete] - показывает только невыполненные задачи.
    ///
    /// Обновляет список задач в состоянии [TaskLoaded], сохраняя все задачи в
    /// [tasks], но изменяя отображаемый список в [filteredTasks].
    on<FilterTasksEvent>((event, emit) {
      if (state is TaskLoaded) {
        final loadedState = state as TaskLoaded;

        /// Если выбран фильтр [TaskFilter.all], то отображаем все задачи.
        /// В противном случае, отображаем задачи в зависимости от их статуса.
        final filteredTasks = event.filter == TaskFilter.all
            ? loadedState.tasks
            : loadedState.tasks
                .where((task) =>
                    task.completed == (event.filter == TaskFilter.completed))
                .toList();

        /// Эмитируем состояние [TaskLoaded] с обновленным списком [filteredTasks],
        /// при этом исходный список [tasks] остается неизменным.
        emit(
            TaskLoaded(tasks: loadedState.tasks, filteredTasks: filteredTasks));
      }
    });
  }
}
