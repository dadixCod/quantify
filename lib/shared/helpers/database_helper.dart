import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, 'quantify.db'), version: 1,
        onCreate: (db, version) {
      db.execute('''
      CREATE TABLE shops(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        address TEXT,
        phone TEXT,
        start TEXT,
        end TEXT
      )
      ''');
    });
  }
}
