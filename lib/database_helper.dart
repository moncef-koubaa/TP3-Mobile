import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper {
  static const _dbName = 'FDTP.db';
  static const _dbVersion = 1;
  static Database? _database;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    // Initialisation FFI pour Desktop
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await databaseFactory.getDatabasesPath();
    final path = join(databasesPath, _dbName);

    return await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(version: _dbVersion, onCreate: _onCreate),
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS book (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price INTEGER NOT NULL,
        image TEXT,
        user_id TEXT
      )
    ''');
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    final db = await database;
    return await db.insert(
      table,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> query(
    String sql, [
    List<Object?>? args,
  ]) async {
    final db = await database;
    return await db.rawQuery(sql, args);
  }

  Future<int> rawDelete(String sql, [List<Object?>? args]) async {
    final db = await database;
    return await db.rawDelete(sql, args);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
