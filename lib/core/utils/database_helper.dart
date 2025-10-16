import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

class OfflineQueueDB {
  static final OfflineQueueDB _instance = OfflineQueueDB._internal();
  factory OfflineQueueDB() => _instance;
  OfflineQueueDB._internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'offline_queue.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE queue (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
        ''');
      },
    );
  }

  Future<void> addRequest(Map<String, dynamic> request) async {
    final database = await db;
    await database.insert('queue', {'data': jsonEncode(request)});
  }

  Future<List<Map<String, dynamic>>> getAllRequests() async {
    final database = await db;
    final result = await database.query('queue');
    return result.map((e) => jsonDecode(e['data'] as String) as Map<String, dynamic>).toList();
  }

  Future<void> clearQueue() async {
    final database = await db;
    await database.delete('queue');
  }
}