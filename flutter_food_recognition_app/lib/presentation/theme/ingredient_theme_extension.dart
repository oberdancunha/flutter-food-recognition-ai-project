// ignore_for_file: ublic_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class IngredientThemeExtension extends ThemeExtension<IngredientThemeExtension> {
  final Color? backgroundColor;
  final Brightness? brightness;

  const IngredientThemeExtension({
    required this.backgroundColor,
    required this.brightness,
  });

  @override
  IngredientThemeExtension copyWith({
    Color? backgroundColor,
    Brightness? brightness,
  }) =>
      IngredientThemeExtension(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        brightness: brightness ?? this.brightness,
      );

  @override
  ThemeExtension<IngredientThemeExtension> lerp(
    covariant ThemeExtension<IngredientThemeExtension>? other,
    double t,
  ) {
    if (other is! IngredientThemeExtension) {
      return this;
    }

    return IngredientThemeExtension(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      brightness: brightness,
    );
  }
}
