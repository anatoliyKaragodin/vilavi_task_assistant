import 'package:flutter/material.dart';
import 'package:vilavi_task_assistant/locator.dart';
import 'app.dart';

/// Основная точка входа в приложение VILAVI Task Assistant.
///
/// Эта функция инициализирует фреймворк Flutter, настраивает зависимости
/// и запускает приложение.
Future<void> main() async {
  // Обеспечивает инициализацию всех необходимых ресурсов Flutter.
  WidgetsFlutterBinding.ensureInitialized();

  // Настраивает зависимости приложения с помощью локатора.
  await setupLocator();

  // Запускает приложение с корневым виджетом App.
  runApp(const App());
}
