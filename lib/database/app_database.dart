
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase(String sql) async {

  final String path = join( await getDatabasesPath(), 'bytebank.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(sql);
  }, version: 1,
      onDowngrade: onDatabaseDowngradeDelete);
}
