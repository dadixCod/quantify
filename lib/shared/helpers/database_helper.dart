import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'quantify.db'),
      version: 1,
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
        db.execute('''
      CREATE TABLE tickets(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        number INTEGER,
        date TEXT,
        time TEXT,
        price REAL,
        clientId INTEGER,
        clientName TEXT,
        clientPhone TEXT,
        isDone INTEGER
      )
        ''');
        db.execute('''
      CREATE TABLE clients(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phone TEXT,
        visits INTEGER,
        totalSpent REAL,
        dept REAL
      )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (newVersion > oldVersion) {}
      },
    );
  }
}
