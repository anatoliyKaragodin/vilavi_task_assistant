import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vilavi_task_assistant/features/tasks/domain/entities/mapper/entities_mapper.dart';

import '../../bloc/task_list/task_list_bloc.dart';

/// [TaskListPage] - главная страница списка задач.
///
/// Эта страница содержит AppBar с фильтром задач и список задач,
/// загружаемых и управляемых с помощью BLoC.
class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Задачи'),
        actions: const [
          _FilterMenu(), // Меню фильтрации задач.
        ],
      ),
      body: Column(
        children: [
          _AddNewTask(), // Поле для добавления новой задачи.
          const Expanded(child: _TaskList()), // Список задач.
        ],
      ),
    );
  }
}

/// [_FilterMenu] - выпадающее меню для фильтрации задач по их статусу.
class _FilterMenu extends StatelessWidget {
  const _FilterMenu();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<TaskFilter>(
      onSelected: (filter) {
        // Отправка события фильтрации задач в BLoC.
        context.read<TaskListBloc>().add(FilterTasksEvent(filter));
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: TaskFilter.all, child: Text('Все задачи')),
        const PopupMenuItem(value: TaskFilter.completed, child: Text('Выполненные')),
        const PopupMenuItem(value: TaskFilter.incomplete, child: Text('Невыполненные')),
      ],
    );
  }
}

/// [_TaskList] - виджет, отображающий список задач.
///
/// Состояние списка задач управляется через [TaskListBloc].
class _TaskList extends StatelessWidget {
  const _TaskList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskListBloc, TaskListState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          // Если задачи загружаются, отображается индикатор загрузки.
          return const Center(child: CircularProgressIndicator());
        } else if (state is TaskLoaded) {
          // Отображаем список задач.
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: state.filteredTasks.length,
            itemBuilder: (context, index) {
              final task = state.filteredTasks[index];
              return _TaskListItem(task: task); // Каждый элемент списка.
            },
          );
        } else if (state is TaskError) {
          // Отображаем сообщение об ошибке, если загрузка завершилась неудачей.
          return Center(child: Text(state.message));
        }
        return Container(); // Пустой контейнер, если ничего не загружено.
      },
    );
  }
}

/// [_TaskListItem] - виджет, отображающий отдельную задачу в списке.
///
/// Каждая задача может быть удалена или ее статус может быть изменен.
class _TaskListItem extends StatelessWidget {
  final TaskEntity task;

  const _TaskListItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        child: Row(
          children: [
            // Кнопка для удаления задачи.
            IconButton(
              onPressed: () =>
                  context.read<TaskListBloc>().add(DeleteTaskEvent(task.id)),
              icon: const Icon(Icons.delete_forever),
            ),
            Expanded(child: Text(task.title)), // Заголовок задачи.
            // Чекбокс для обновления статуса задачи.
            Checkbox(
              value: task.completed,
              onChanged: (value) {
                context.read<TaskListBloc>().add(
                  UpdateTaskStatusEvent(
                    TaskEntity(
                      id: task.id,
                      title: task.title,
                      completed: value ?? task.completed,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// [_AddNewTask] - виджет для добавления новой задачи.
///
/// После ввода новой задачи и нажатия "Enter", задача добавляется в список через BLoC.
class _AddNewTask extends StatelessWidget {
  _AddNewTask();

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        children: [
          // Текстовое поле для ввода новой задачи.
          Expanded(
            child: TextField(
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  // Добавляем новую задачу через событие BLoC.
                  context.read<TaskListBloc>().add(AddTaskEvent(value));
                  _controller.clear(); // Очищаем поле после добавления.
                }
              },
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Новая задача',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
