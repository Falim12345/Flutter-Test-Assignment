import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseRepository {
  static final DatabaseRepository _instance = DatabaseRepository._internal();
  static Database? _database;

  factory DatabaseRepository() {
    return _instance;
  }

  DatabaseRepository._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'buildings.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE buildings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        numberOfFloors INTEGER,
        currentFloor INTEGER DEFAULT 0
      )
    ''');
  }

  Future<int> insertBuilding(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('buildings', row);
  }

  Future<List<Map<String, dynamic>>> queryAllBuildings() async {
    Database db = await database;
    return await db.query('buildings');
  }

  Future<int> updateCurrentFloor(int id, int newFloor) async {
    Database db = await database;
    return await db.update(
      'buildings',
      {'currentFloor': newFloor},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Map<String, dynamic>> getBuildingById(int id) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'buildings',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      throw Exception('Building not found');
    }
  }
}
