import 'package:sqflite/sqflite.dart';

import '../../models/Item_model.dart';
import 'package:path/path.dart';

class ItemLocalDataSource {
  static final ItemLocalDataSource instance = ItemLocalDataSource._();

  ItemLocalDataSource._();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'items.db');
    print("📂 SQLite Database Path: $path"); // ✅ Debug database location
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE items (
          id TEXT PRIMARY KEY,
          name TEXT,
          image TEXT,
          smalldescription TEXT,
          description TEXT,
          isAvailable INTEGER,
          termsAndConditions TEXT,
          telephon TEXT,
          address TEXT
        )
      ''');
    });
  }

  Future<void> cacheItems(List<ItemModel> items) async {
    final database = await db;
    final batch = database.batch();
    for (final item in items) {
      batch.insert(
          'items', item.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
  }

  Future<List<ItemModel>> getCachedItems() async {
    final database = await db;
    final maps = await database.query('items');
    return maps.map((map) => ItemModel.fromJson(map)).toList();
  }


  Future<ItemModel?> getItemById(String id) async {
    final database = await db;
    final maps = await database.query(
        'items', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return ItemModel.fromJson(maps.first); // ✅ Return the matching item
    }
    return null;
  }

}

