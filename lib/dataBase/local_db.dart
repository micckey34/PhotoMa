import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


var ldb = LocalDatabase.instance;

class LocalDatabase {
  static final _databaseName = 'MyDatabase.db';
  static final table = 'myData';
  static final id = '_id';
  static final myId = '_user_id';

  LocalDatabase._privateConstructor();
  static final LocalDatabase instance = LocalDatabase._privateConstructor();
  
  static Database _database;
  Future <Database> get database async{
    if(_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(path,
        version: 1,
        onCreate: _onCreate);
  }
  
  

  FutureOr<void> _onCreate(Database db, int version) async{
    await db.execute('''
    CREATE TABLE $table(
    $id INTEGER PRIMARY KEY,
    $myId INTEGER NOT NULL
    )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database; //DBにアクセスする
    return await db.insert(table, row); //テーブルにマップ型のものを挿入。追加時のrowIDを返り値にする
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database; //DBにアクセスする
    return await db.query(table); //全件取得
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database; //DBにアクセスする
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$id = ?', whereArgs: [id]);
  }
}