import 'package:flutter/material.dart';

import 'ingredient_theme_extension.dart';

ThemeData get theme => ThemeData(
      fontFamily: 'PTSans',
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Color(0xFF553C32)),
        titleSmall: TextStyle(color: Color(0XFFFFFFFF)),
      ),
      colorScheme: const ColorScheme.light(
        primary: Color(0XFFFFFFFF),
        secondary: Color(0XFF000000),
        tertiary: Color(0xFFF44336),
      ),
      cardTheme: CardTheme(
        shape: const RoundedRectangleBorder(),
        elevation: 1.5,
        shadowColor: Colors.grey.withOpacity(0.7),
      ),
      extensions: const <ThemeExtension>[
        IngredientThemeExtension(
          backgroundColor: Color(0xFFEEEEEE),
          brightness: Brightness.dark,
        ),
      ],
      useMaterial3: true,
    );
