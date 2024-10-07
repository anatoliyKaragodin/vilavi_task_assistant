import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:vilavi_task_assistant/features/tasks/data/models/mapper/models_mapper.dart';
import 'package:vilavi_task_assistant/features/tasks/data/datasources/remote/tasks_rds.dart';

import '../../../../../core/error/exeption.dart';

/// Реализация удалённого источника данных задач.
///
/// Этот класс [TasksRDSImpl] реализует интерфейс [TasksRDS] и использует
/// библиотеку Dio для выполнения HTTP-запросов к удалённому API.
class TasksRDSImpl implements TasksRDS {
  final Dio _dio;

  /// Конструктор класса [TasksRDSImpl], принимает экземпляр [Dio].
  TasksRDSImpl(this._dio);

  @override
  Future<List<TaskModel>> getAllTasks() async {
    try {
      // Выполняем GET-запрос к API для получения всех задач
      final response =
      await _dio.get('https://jsonplaceholder.typicode.com/todos');

      // Если запрос успешен, преобразуем JSON в список моделей TaskModel
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        // Преобразуем полученные данные в список объектов TaskModel
        return data.map((json) => TaskModelMapper.fromMap(json)).toList();
      } else {
        // В случае неуспешного запроса выбрасываем исключение ServerException
        throw ServerException();
      }
    } catch (e) {
      // В случае возникновения ошибки при выполнении запроса выбрасываем исключение ServerException
      throw ServerException();
    }
  }
}