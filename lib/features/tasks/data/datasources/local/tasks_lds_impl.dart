import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vilavi_task_assistant/features/tasks/data/models/mapper/models_mapper.dart';
import 'package:vilavi_task_assistant/features/tasks/data/datasources/local/tasks_lds.dart';

import '../../../../../core/error/exeption.dart';



/// Реализация локального источника данных задач с использованием SharedPreferences.
class TasksLDSImpl implements TasksLDS {
  final SharedPreferences _sharedPreferences;

  TasksLDSImpl(this._sharedPreferences);

  /// Ключ для хранения задач в SharedPreferences.
  static const String _tasksKey = 'CACHED_TASKS';

  @override
  Future<void> addNewTask(TaskModel task) async {
    try {
      // Получаем текущий список задач из SharedPreferences
      final List<TaskModel> tasks = await getAllTasks();
      tasks.add(task);

      // Сохраняем обновленный список
      await _saveTasksToCache(tasks);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteTask(int id) async {
    try {
      // Получаем текущий список задач
      final List<TaskModel> tasks = await getAllTasks();

      // Удаляем задачу по id
      tasks.removeWhere((task) => task.id == id);

      // Сохраняем обновленный список
      await _saveTasksToCache(tasks);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    try {
      final jsonString = _sharedPreferences.getString(_tasksKey);

      if (jsonString != null) {
        // Декодируем JSON и преобразуем в список моделей
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.map((json) => TaskModelMapper.fromMap(json)).toList();
      } else {
        // Если данных нет, возвращаем пустой список
        return [];
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> updateTaskStatus(TaskModel updatedTask) async {
    try {
      // Получаем текущий список задач
      final List<TaskModel> tasks = await getAllTasks();

      // Обновляем задачу по id
      final taskIndex = tasks.indexWhere((task) => task.id == updatedTask.id);
      if (taskIndex != -1) {
        tasks[taskIndex] = updatedTask;
      } else {
        tasks.add(updatedTask);
      }

      // Сохраняем обновленный список
      await _saveTasksToCache(tasks);
    } catch (e) {
      throw CacheException();
    }
  }

  /// Метод для сохранения списка задач в SharedPreferences.
  Future<void> _saveTasksToCache(List<TaskModel> tasks) async {
    final List<Map<String, dynamic>> tasksJson = tasks.map((task) => task.toMap()).toList();
    final jsonString = json.encode(tasksJson);
    final success = await _sharedPreferences.setString(_tasksKey, jsonString);

    if (!success) {
      throw CacheException();
    }
  }
}