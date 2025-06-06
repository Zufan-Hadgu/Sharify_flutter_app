import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/user_model.dart';

class AuthLocal {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'app_database.db');

    return await openDatabase(
      path,
      version: 2,  // ✅ Increase version from 1 to 2
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE users (
          id TEXT PRIMARY KEY,
          name TEXT,
          email TEXT UNIQUE,
          password TEXT,
          role TEXT,
          profilePicture TEXT DEFAULT 'default.png'
        )
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion == 1) {
          await db.execute("ALTER TABLE users ADD COLUMN profilePicture TEXT DEFAULT 'default.png';");
          print("Profile picture column added during upgrade!");
        }
      },
    );
  }


  Future<void> saveUser(UserModel user) async {
    final db = await database;
    await db.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final db = await database;
    final result = await db.query('users', where: 'email = ?', whereArgs: [email]);

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }
}


