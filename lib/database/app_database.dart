import 'package:bytebank/database/dao/contato_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'bytebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContatoDao.sql);
    },
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete,
  );
}
