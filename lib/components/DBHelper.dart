import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:yellow_class_assignment/components/movieInfo.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();

  static Database? _database;

  DBHelper._init();

  static const String ID = 'id';
  static const String PHOTONAME = 'photoName';
  static const String MOVIENAME = 'movieName';
  static const String DIRNAME = 'dirName';
  static const String TABLE = 'photoTable';
  static const String DB_NAME = 'movies.db';

  static final List<String> values = [ID, MOVIENAME, DIRNAME, PHOTONAME];

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DB_NAME);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $TABLE (
            $ID INTEGER PRIMARY KEY AUTOINCREMENT,
            $PHOTONAME TEXT NOT NULL, 
            $MOVIENAME TEXT NOT NULL, 
            $DIRNAME TEXT NOT NULL)
        ''');
  }

  Future<MovieInfo> insertMovie(MovieInfo movieInfo) async {
    final db = await instance.database;
    final id = await db.insert(TABLE, movieInfo.toMap());

    return movieInfo.copy(id: id);
  }

  Future<MovieInfo> readMovie(int id) async {
    final db = await instance.database;

    final maps = await db.query(TABLE,
        columns: DBHelper.values, where: '$ID = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return MovieInfo.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<MovieInfo>> getMovies() async {
    final db = await instance.database;
    final result = await db.query(TABLE);

    return result.map((json) => MovieInfo.fromMap(json)).toList();
  }

  Future<int> update(MovieInfo movieInfo) async {
    final db = await instance.database;
    return db.update(
      TABLE,
      movieInfo.toMap(),
      where: '$ID = ?',
      whereArgs: [movieInfo.id],
    );
  }

  Future<int> delete(int? id) async {
    var db = await instance.database;
    return await db.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
    _database = null;
  }
}
