import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/contact.dart';
import '../model/sms.dart';

class DBhelper extends ChangeNotifier {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'db_helper.db'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE IF NOT EXISTS contact(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, phone TEXT)');
        db.execute(
            'CREATE TABLE IF NOT EXISTS messages(id INTEGER PRIMARY KEY, contactid INTEGER, phone TEXT, message TEXT, me TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> dbInsertMessage(SMS c) async {
    final db = await DBhelper.database();
    await db.insert(
      'messages',
      c.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<dynamic>> dbGetMessagesbyContactId(int contactId) async {
    final db = await DBhelper.database();
    final List<dynamic> messages = await db
        .query('messages', where: 'contactid = ?', whereArgs: [contactId]);
    print(messages);
    return messages;
  }

  //unused
  static void dbInsertContact(ContactModel c) async {
    final db = await DBhelper.database();
    await db.insert(
      'contact',
      c.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> dbSelectContact() async {
    final db = await DBhelper.database();
    final List<Map<String, dynamic>> maps = await db.query('contact');
    return maps;
  }

  static Future<int> dbDeleteContactById(int Pickid) async {
    final db = await DBhelper.database();
    await db.delete('messages', where: 'contactid = ?', whereArgs: [Pickid]);
    return await db.delete('contact', where: 'id = ?', whereArgs: [Pickid]);
  }
}
