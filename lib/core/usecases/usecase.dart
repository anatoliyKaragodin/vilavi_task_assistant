import 'dart:async';

import 'package:dartz/dartz.dart';

import '../error/failure.dart';

/// Абстрактный класс для использования с [UseCase].
///
/// [Type] — тип результата, возвращаемого в случае успеха,
/// а [Params] — тип параметров, необходимых для выполнения операции.
abstract class UseCase<Type, Params> {
  /// Выполняет операцию, возвращая результат в виде [Either].
  ///
  /// Возвращает [Failure] в случае ошибки или [Type] в случае успеха.
  Future<Either<Failure, Type>> call(Params params);
}