
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/contact.dart';

Future<Database> getDatabase() async {

  final String path = join( await getDatabasesPath(), 'bytebank.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute('CREATE TABLE contacts('
        'id INTEGER PRIMARY KEY, '
        'name TEXT, '
        'account_number INTEGER)');
  }, version: 1,
      onDowngrade: onDatabaseDowngradeDelete);

  //minha versao q estava ok.
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // final database = openDatabase(
  //   join(await getDatabasesPath(), 'bytebank.db'),
  //     onCreate: (db, version){
  //       return db.execute('CREATE TABLE contacts('
  //           'id INTEGER PRIMARY KEY, '
  //           'name TEXT, '
  //           'account_number INTEGER)');
  //     },
  //   version: 1,
  //   onDowngrade: onDatabaseDowngradeDelete //sobe a versao e depois volta e o banco fica limpo !
  // );

  //codigo passado na alura
  // return getDatabasesPath().then((dbpath) {
  //   final String path = join(dbpath, 'bytebank.db');
  //   openDatabase(path, onCreate: (db, version) {
  //     db.execute('CREATE TABLE contacts('
  //         'id INTEGER PRIMARY KEY, '
  //         'name TEXT, '
  //         'account_number INTEGER)');
  //   }, version: 1);
  // }
  // ).catchError((error) => debugPrint(error.toString()) );

  // return database;
}

Future<int> save(Contact contact) async{

  final Database db = await getDatabase();

  final Map<String, dynamic> contactMap = Map();
  contactMap['name'] = contact.name;
  contactMap['account_number'] = contact.accountNumber;
  return db.insert('contacts', contactMap);

 //  return createDatabase().then((db){
 //   final Map<String, dynamic> contactMap = Map();
 //   contactMap['name'] = contact.name;
 //   contactMap['account_number'] = contact.accountNumber;
 //    return db.insert('contacts', contactMap );
 //
 // });

}

Future<List<Contact>> findAll() async{

  final Database db = await getDatabase();
  final List<Map<String,dynamic>> result = await db.query('contacts');
  final List<Contact> contacts = [];
  for(Map<String, dynamic> row in result){
        final Contact contact = Contact(
            row['id'],
            row['name'],
            row['account_number']
        );
        contacts.add(contact);
      }
      return contacts;

  // return createDatabase().then((db) {
  //   final executor = db?.query('contacts').then((maps){
  //     final List<Contact> contacts = [];
  //     for(Map<String, dynamic> map in maps){
  //   //       final Contact contact = Contact(
  //   //           map['id'],
  //   //           map['name'],
  //   //           map['account_number']
  //   //       );
  //   //       contacts.add(contact);
  //   //     }
  //   //     return contacts;
  //   });
  //
  //   if(executor != null){
  //     return executor;
  //   }else{
  //     throw Exception('Erro ao pesquisar na base de dados');
  //   }
  // });
}