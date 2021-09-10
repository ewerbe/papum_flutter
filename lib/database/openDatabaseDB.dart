import 'package:papum/database/freteDAO.dart';
import 'package:papum/database/freteiroDAO.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'freteiroDAO.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'papumdb.db');

  return openDatabase(
      path,
      onCreate: (db, version){
        db.execute(FreteiroDAO.sqlTabelaPaciente);
        db.execute(FreteDAO.sqlTabela);
      },
      version: 1);
}