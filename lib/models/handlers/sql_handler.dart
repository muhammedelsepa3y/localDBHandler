import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlHandler {
  Database? _database;

  // Initialize the database
  Future<void> initDatabase() async {
    if (_database != null) {
      return;
    }
    try {
      String path = join(await getDatabasesPath(), 'my_database.db');
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          // Create tables here
          await db.execute('''
            CREATE TABLE IF NOT EXISTS users (
              id INTEGER PRIMARY KEY,
              name TEXT,
              email TEXT
            )
          ''');
        },
      );
    } catch (ex) {
      print("Error initializing database: $ex");
    }
  }

  // Create a table
  Future<void> createTable(String tableName, String tableDefinition) async {
    await _database?.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        $tableDefinition
      )
    ''');
  }

  // Insert data into a table
  Future<int> insert(String tableName, Map<String, dynamic> data) async {
    return await _database!.insert(tableName, data);
  }

  // Update data in a table
  Future<int> update(String tableName, Map<String, dynamic> data, int id) async {
    return await _database!.update(
      tableName,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete data from a table
  Future<int> delete(String tableName, int id) async {
    return await _database!.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Query data from a table
  Future<List<Map<String, dynamic>>> query(
      String tableName, {
        List<String>? columns,
        String? where,
        List<dynamic>? whereArgs,
        String? orderBy,
      }) async {
    return await _database!.query(
      tableName,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
    );
  }

  // Run a custom SQL query
  Future<List<Map<String, dynamic>>> customQuery(String query) async {
    return await _database!.rawQuery(query);
  }

  // Close the database
  Future<void> closeDatabase() async {
    await _database?.close();
    _database = null;
  }
}
