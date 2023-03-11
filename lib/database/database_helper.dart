import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

import 'package:restaurant_api/models/favorite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper.internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper.internal();

  Future<Database> get database async {
    _database = await _initializeDb();

    return _database;
  }

  static const String _tableName = 'favorite';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(join(path, 'favorite_db.db'),
        onCreate: (db, version) async {
      await db.execute(
        '''CREATE TABLE $_tableName (
               id INTEGER PRIMARY KEY,
               name TEXT, 
               restaurantId TEXT, 
               city TEXT, 
               rating DOUBLE,
               pictureId TEXT
             )''',
      );
    }, version: 1);
    return db;
  }

  Future<void> insert(Favorite favorite) async {
    final Database db = await database;
    await db.insert(_tableName, favorite.toMap());
    print('data saved');
  }

  Future<List<Favorite>> getFavorite() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((e) => Favorite.fromMap(e)).toList();
  }

  Future<void> delete(String id) async {
    final db = await database;

    await db.delete(
      _tableName,
      where: 'restaurantId = ?',
      whereArgs: [id],
    );
  }
}
