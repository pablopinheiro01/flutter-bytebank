
import 'package:sqflite/sqflite.dart';

import '../../models/contact.dart';
import '../app_database.dart';

class ContactDAO{

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';

  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  Future<int> save(Contact contact) async{

    final Database db = await getDatabase(tableSql);
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert(_tableName, contactMap);

  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }

  Future<List<Contact>> findAll() async{

    final Database db = await getDatabase(tableSql);
    final List<Map<String,dynamic>> result = await db.query(_tableName);
    List<Contact> contacts = _toList(result);
    return contacts;
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = [];
    for(Map<String, dynamic> row in result){
      final Contact contact = Contact(
          row[_id],
          row[_name],
          row[_accountNumber]
      );
      contacts.add(contact);
    }
    return contacts;
  }

  Future<int> update(Contact contact) async{
    final Database db = await getDatabase(tableSql);
    final Map<String, dynamic> value = _toMap(contact);
    return db.update(_tableName, value, where: '$_id = ?', whereArgs: [contact.id]);
  }

  Future<int> delete(int id) async{
    final Database db = await getDatabase(tableSql);
    return db.delete(_tableName, where: '$_id = ?', whereArgs: [id] );
  }

}