import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model/item.dart'; // Model class

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database? _db;

  Future<Database> get db async {
    return _db ??= await initDb();
  }

  DatabaseHelper.internal();

  // Initialize the database
  Future<Database> initDb() async {
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

  // Insert item into the database
  Future<int> insertItem(Item item) async {
    var dbClient = await db;
    return await dbClient.insert('Items', item.toMap());
  }

  // Get all items from the database
  Future<List<Item>> getItems() async {
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query('Items');
    return result.map((data) => Item.fromMap(data)).toList();
  }

  // Update an existing item
  Future<int> updateItem(Item item) async {
    var dbClient = await db;
    return await dbClient.update('Items', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
  }

  // Delete an item from the database
  Future<int> deleteItem(int id) async {
    var dbClient = await db;
    return await dbClient.delete('Items', where: 'id = ?', whereArgs: [id]);
  }

  // Search items based on query
  Future<List<Item>> searchItems(String query) async {
    var dbClient = await db;
    var result = await dbClient.query(
      'Items',
      where: 'name LIKE ?', // Search by name
      whereArgs: ['%$query%'], // Use wildcard search
    );

    List<Item> items = result.isNotEmpty
        ? result.map((item) => Item.fromMap(item)).toList()
        : [];

    return items;
  }
}
