//db 
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model/item.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database? _db;

  Future<Database> get db async {
    return _db ??= await initDb();
  }

  DatabaseHelper.internal();

  // Initialize the database
  initDb() async {
    String path = join(await getDatabasesPath(), 'items.db');
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  // Create the Items table
  void _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE Items(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL
      )
      ''',
    );
  }

  // Insert item
  Future<int> insertItem(Item item) async {
    var dbClient = await db;
    return await dbClient.insert('Items', item.toMap());
  }

  // Get all items
  Future<List<Item>> getItems() async {
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query('Items');
    return result.map((data) => Item.fromMap(data)).toList();
  }

  // Update item
  Future<int> updateItem(Item item) async {
    var dbClient = await db;
    return await dbClient.update('Items', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
  }

  // Delete item
  Future<int> deleteItem(int id) async {
    var dbClient = await db;
    return await dbClient.delete('Items', where: 'id = ?', whereArgs: [id]);
  }
}