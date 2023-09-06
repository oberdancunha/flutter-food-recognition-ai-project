import 'package:flutter/foundation.dart';
import 'package:flutter_food_recognition_dependency_module/flutter_food_recognition_dependency_module.dart';

@immutable
abstract class ValueObjects<T extends Object> {
  Result<T, void> get value;

  T getOrError() => value.getOrThrow();

  @override
  bool operator ==(covariant ValueObjects<T> other) {
    if (identical(this, other)) {
      return true;
    }

    return other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
