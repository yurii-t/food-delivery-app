import 'package:flutter/material.dart';

abstract class AppGradients {
  static const orangeGradient = LinearGradient(
    colors: [
      Color(0xFFEA7000),
      Color(0xFFFFC123),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
