import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../database/DBhelper.dart';
import 'sms.dart';

class ContactModel {
  final int? id;
  final String firstName;
  final String lastName;
  final String phone;
  final String picture;
  final List<SMS>? msgTab;

  const ContactModel(
      {this.id,
      this.msgTab,
      required this.firstName,
      required this.lastName,
      required this.phone,
      this.picture = "assets/ppBlank.png"});

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
    };
  }

  @override
  String toString() {
    return '{firstName: $firstName,lastName: $lastName,phone: $phone}';
  }
}

class ContactProvider extends ChangeNotifier {
//--------------------------------//
//-------------SMS----------------//
//--------------------------------//
  List<SMS> msg = [];

  sendSms(SMS toSend) async {
    //push to list
    msg.add(toSend);
    //save in db
    await DBhelper.dbInsertMessage(toSend);

    //send
    //await selectMessagesById(toSend.id!);
    notifyListeners();
  }

  Future<List<SMS>> selectMessagesById(int contactId) async {
    final data = await DBhelper.dbGetMessagesbyContactId(contactId);
    print(data);
    msg = data
        .map((item) => SMS(
              id: item['id'],
              contactId: item['contactid'],
              phone: item['phone'],
              message: item['message'],
              me: item['me'],
            ))
        .toList();
    notifyListeners();
    return msg;
  }

//--------------------------------//
//-------------contact------------//
//--------------------------------//
  List<ContactModel> contact = [];

  Future insert(ContactModel c) async {
    final db = await DBhelper.database();
    await db.insert(
      'contact',
      c.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    contact.add(c);
    await selectContact();
  }

  Future<void> selectContact() async {
    final dataList = await DBhelper.dbSelectContact();
    print(dataList);
    contact = dataList
        .map((item) => ContactModel(
              id: item['id'],
              firstName: item['firstName'],
              lastName: item['lastName'],
              phone: item['phone'],
            ))
        .toList();
    notifyListeners();
  }

  Future<void> deleteProductById(pickId) async {
    print(pickId);
    await DBhelper.dbDeleteContactById(pickId);
    await selectContact();
  }

  Future<void> updateContactNameById(id, ContactModel newContact) async {
    final db = await DBhelper.database();
    await db.update(
      'contact',
      {
        'firstName': newContact.firstName,
        'lastName': newContact.lastName,
        'phone': newContact.phone,
      },
      where: "id = ?",
      whereArgs: [id],
    );
    await selectContact();
  }
}
