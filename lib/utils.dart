import 'package:flutter/material.dart';
import 'package:hangout/style/styles.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import './model/contact.dart';
import 'main.dart';
import 'model/sharedpreferences.dart';
import 'style/styles.dart' as s;



dynamic validator(value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}

dynamic validator_init(value, initial) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  } else if (value == initial) {
    return 'Please change value';
  }
  return null;
}
