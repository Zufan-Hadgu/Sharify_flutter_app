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

  /// Initialize SQLite Database Without Password Storage
  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'app_database.db');

    return await openDatabase(
      path,
      version: 3, // ✅ Increase version to trigger migration
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE users (
          id TEXT PRIMARY KEY,
          name TEXT,
          email TEXT UNIQUE,
          role TEXT,
          profilePicture TEXT DEFAULT 'default.png'
        )
      '''); // ❌ No password column
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 3) {  // ✅ Ensure migration runs
          await db.execute("CREATE TEMP TABLE users_backup AS SELECT id, name, email, role, profilePicture FROM users;");
          await db.execute("DROP TABLE users;");
          await db.execute('''
          CREATE TABLE users (
            id TEXT PRIMARY KEY,
            name TEXT,
            email TEXT UNIQUE,
            role TEXT,
            profilePicture TEXT DEFAULT 'default.png'
          )
        ''');
          await db.execute("INSERT INTO users SELECT id, name, email, role, profilePicture FROM users_backup;");
          await db.execute("DROP TABLE users_backup;");
          print("🔄 Password column removed during database migration!");
        }
      },
    );
  }

  /// Save User Data Without Password in SQLite
  Future<void> saveUser(UserModel user) async {
    final db = await database;
    print("📌 Saving user details in SQLite (without password)...");

    await db.insert(
      'users',
      {
        'id': user.id,
        'name': user.name,
        'email': user.email.trim(),
        'role': user.role,
        'profilePicture': user.profilePicture,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print("✅ User stored in SQLite (no password).");
  }

  /// Fetch User from SQLite by Email (No Password Included)
  Future<UserModel?> getUserByEmail(String email) async {
    final db = await database;
    print("🔍 Checking SQLite for user with email: $email");

    final result = await db.query('users', where: 'email = ?', whereArgs: [email.trim()]);
    if (result.isNotEmpty) {
      print("✅ User found in SQLite: ${result.first}");
      return UserModel.fromMap(result.first);
    }

    print("❌ No matching user found in SQLite.");
    return null;
  }
}