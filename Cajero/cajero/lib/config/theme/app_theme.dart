import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.blue,
      scaffoldBackgroundColor: Colors.grey[200],
      appBarTheme: AppBarTheme(backgroundColor: Colors.grey[200]));
}
