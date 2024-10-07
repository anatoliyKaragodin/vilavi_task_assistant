import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';

import '../../../../../core/router/router.dart';

/// Экран авторизации.
class AuthPage extends StatefulWidget {
  /// Создает экземпляр [AuthPage].
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _errorMessage;

  // Захардкоженные логин и пароль
  final String _hardcodedLogin = 'test';
  final String _hardcodedPassword = 'password123';

  /// Метод проверки логина и пароля.
  void _authenticate() {
    final login = _loginController.text;
    final password = _passwordController.text;

    if (login.trim() == _hardcodedLogin &&
        password.trim() == _hardcodedPassword.trim()) {
      // Если логин и пароль верные, переходим на экран задач
      Get.toNamed(AppRoutes.tasks);
    } else {
      // Если логин или пароль неверные, показываем ошибку
      setState(() {
        _errorMessage = 'Неверный логин или пароль';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Авторизация'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LoginField(controller: _loginController),
              const Gap(16),
              _PasswordField(controller: _passwordController),
              const Gap(16.0),
              if (_errorMessage != null) _ErrorMessage(message: _errorMessage!),
              const Gap(16.0),
              _LoginButton(onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _authenticate();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

/// Поле ввода логина.
///
/// Принимает [controller] для управления текстом в поле ввода.
class _LoginField extends StatelessWidget {
  /// Создает экземпляр [_LoginField].
  const _LoginField({required this.controller});

  /// Контроллер для управления текстом.
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Логин',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Введите логин';
        }
        return null;
      },
    );
  }
}

/// Поле ввода пароля.
///
/// Принимает [controller] для управления текстом в поле ввода.
class _PasswordField extends StatelessWidget {
  /// Создает экземпляр [_PasswordField].
  const _PasswordField({required this.controller});

  /// Контроллер для управления текстом.
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Пароль',
        border: OutlineInputBorder(),
      ),
      obscureText: true, // Скрывает текст пароля
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Введите пароль';
        }
        return null;
      },
    );
  }
}

/// Виджет для отображения сообщения об ошибке.
///
/// Принимает [message] — текст сообщения для отображения.
class _ErrorMessage extends StatelessWidget {
  /// Создает экземпляр [_ErrorMessage].
  const _ErrorMessage({required this.message});

  /// Текст сообщения об ошибке.
  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: const TextStyle(color: Colors.red),
    );
  }
}

/// Кнопка для входа в систему.
///
/// Принимает [onPressed] — функцию обратного вызова при нажатии на кнопку.
class _LoginButton extends StatelessWidget {
  /// Создает экземпляр [_LoginButton].
  const _LoginButton({required this.onPressed});

  /// Функция обратного вызова, вызываемая при нажатии на кнопку.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Войти'),
    );
  }
}