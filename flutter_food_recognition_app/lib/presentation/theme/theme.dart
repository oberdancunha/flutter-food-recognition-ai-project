import 'package:flutter/material.dart';

ThemeData get theme => ThemeData(
      fontFamily: 'PTSans',
      colorScheme: const ColorScheme.light(
        primary: Color(0XFFFFFFFF),
        secondary: Color(0XFF000000),
        tertiary: Color(0xFF553C32),
      ),
      cardTheme: CardTheme(
        shape: const RoundedRectangleBorder(),
        elevation: 1.5,
        shadowColor: Colors.grey.withOpacity(0.7),
      ),
      useMaterial3: true,
    );
