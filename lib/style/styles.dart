import 'package:flutter/material.dart';

abstract class Style {

  static TextStyle settingsText = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );

  static InputDecoration inactiveTextField = const InputDecoration(
    border: InputBorder.none,
  );

  static InputDecoration activeTextField = const InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
  );
}
