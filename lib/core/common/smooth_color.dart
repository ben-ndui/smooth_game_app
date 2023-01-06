import 'dart:ui';

import 'package:flutter/material.dart';

class SmoothColor {
  Color primary = Colors.yellow;

  Color accent = const Color(0xFFF23030);

  Color secondary = const Color(0xFF267365);

  Color alertColor = const Color(0xFF010D23);

  Color danger = const Color(0xFFFF1744);

  Color success = const Color(0xFF4DAA57);

  ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
        primarySwatch: Colors.red,
        primaryColor: isDarkTheme ? secondary : primary,
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        indicatorColor: isDarkTheme ? primary : secondary,
        hintColor: isDarkTheme ? primary : secondary,
        highlightColor: isDarkTheme ? secondary : primary,
        hoverColor: isDarkTheme ? secondary : primary,
        focusColor: isDarkTheme ? primary : secondary,
        disabledColor: Colors.grey,
        textSelectionTheme:
            TextSelectionThemeData(selectionColor: isDarkTheme ? secondary : primary),
        cardColor: isDarkTheme ? const Color(0xFF151515) : secondary,
        canvasColor: isDarkTheme ? primary : Colors.grey[50],
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: isDarkTheme ? const ColorScheme.dark() : const ColorScheme.light()),
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: isDarkTheme ? Colors.black.withOpacity(0.03) : primary,
          filled: isDarkTheme ? true : false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(200),
            borderSide: BorderSide.none,
          ),
          labelStyle: TextStyle(
            color: isDarkTheme ? primary : secondary,
            fontStyle: FontStyle.italic,
          ),
          hintStyle: TextStyle(
            color: isDarkTheme ? primary : secondary,
            fontStyle: FontStyle.italic,
          ),
        ));
  }
}
