import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static final DatabaseHelper instance = DatabaseHelper();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/tasks.db';

    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE tasks ADD COLUMN completed INTEGER DEFAULT 0');
        }
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        completed INTEGER DEFAULT 0
      )
    ''');
  }

  Future<int> insertTask(String title) async {
    final db = await database;
    return await db.insert('tasks', {'title': title});
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await database;
    return await db.query('tasks');
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateTask(int id, Map<String, dynamic> values) async {
    final db = await database;
    return await db.update(
      'tasks',
      values,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateTaskCompletion(int id, bool completed) async {
    final db = await database;
    return await db.update(
      'tasks',
      {'completed': completed ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteCompletedTasks() async {
    final db = await database;
    return await db.delete('tasks', where: 'completed = ?', whereArgs: [1]);
  }
}
