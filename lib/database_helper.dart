import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Enable ffi only on desktop platforms
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tasks.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        due_date TEXT,
        priority TEXT,
        completed INTEGER DEFAULT 0
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE tasks ADD COLUMN completed INTEGER DEFAULT 0');
    }
  }

  Future<int> insertTask(Map<String, dynamic> task) async {
    try {
      final db = await database;
      return await db.insert('tasks', task);
    } catch (e) {
      print('Insert Task Error: $e');
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    try {
      final db = await database;
      return await db.query('tasks');
    } catch (e) {
      print('Get Tasks Error: $e');
      return [];
    }
  }

  Future<int> deleteTask(int id) async {
    try {
      final db = await database;
      return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Delete Task Error: $e');
      return -1;
    }
  }

  Future<int> updateTask(int id, Map<String, dynamic> values) async {
    try {
      final db = await database;
      return await db.update(
        'tasks',
        values,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Update Task Error: $e');
      return -1;
    }
  }

  Future<int> updateCompletion(int id, bool completed) async {
    try {
      final db = await database;
      return await db.update(
        'tasks',
        {'completed': completed ? 1 : 0},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Update Completion Error: $e');
      return -1;
    }
  }

  Future<int> deleteCompletedTasks() async {
    try {
      final db = await database;
      return await db.delete('tasks', where: 'completed = ?', whereArgs: [1]);
    } catch (e) {
      print('Delete Completed Tasks Error: $e');
      return -1;
    }
  }
}

