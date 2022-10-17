import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'view/homepage.dart';
import 'view/contactpage.dart';

Future main() async {
  runApp(MaterialApp(
    home: HomePage(),
    routes: {
      "home": (context) => HomePage(),
      "contactpafe": (context) => ContactPage()
    },
  ));
}
