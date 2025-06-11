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
    print("📂 SQLite Database Path: $path");

    return await openDatabase(
      path,
      version: 5, // ✅ Updated version (incremented to 5)
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE items (
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          image TEXT,
          smalldescription TEXT,
          description TEXT,
          isAvailable INTEGER,
          termsAndConditions TEXT,
          telephon TEXT,
          address TEXT,
          note TEXT DEFAULT "",
          borrowedBy TEXT DEFAULT NULL -- ✅ Added missing column
        );
        ''');

        await db.execute('''
        CREATE TABLE borrowed_items (
          id TEXT PRIMARY KEY,
          itemId TEXT NOT NULL,
          userId TEXT NOT NULL,
          name TEXT NOT NULL,
          image TEXT NOT NULL,
          smalldescription TEXT NOT NULL,
          borrowedAt TEXT DEFAULT CURRENT_TIMESTAMP
        );
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 5) {  // ✅ Ensure migration runs only if upgrading
          print("🔄 Running database migration to version $newVersion");

          await db.execute('ALTER TABLE items ADD COLUMN borrowedBy TEXT DEFAULT NULL;'); // ✅ Add column safely

          print("✅ Migration completed.");
        }
      },
    );
  }

  Future<void> cacheItems(List<ItemModel> items) async {
    final database = await db;
    final batch = database.batch();

    for (final item in items) {
      batch.insert(
        'items',
        item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
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
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      print("✅ Found Item: ${maps.first}"); // ✅ Debugging output
      return ItemModel.fromJson(maps.first);
    }

    print("❌ Item not found with ID: $id");
    return null;
  }

  Future<void> borrowItemLocally(String itemId, String userId) async {
    final database = await db;
    final item = await getItemById(itemId);

    if (item == null) {
      throw Exception("Item not available locally.");
    }

    final existingItems = await database.query(
      'borrowed_items',
      where: 'itemId = ? AND userId = ?',
      whereArgs: [itemId, userId],
    );

    if (existingItems.isNotEmpty) {
      return; // ✅ Exit without inserting duplicate entry
    }

    await database.insert('borrowed_items', {
      'id': "$itemId-$userId-${DateTime.now().millisecondsSinceEpoch}",
      'itemId': itemId,
      'userId': userId,
      'name': item.name,
      'image': item.image,
      'smalldescription': item.smalldescription,
      'borrowedAt': DateTime.now().toIso8601String(),
    });
  }
}