// import 'dart:io';
// import 'package:sqflite/sqflite.dart';
//
// class DatabaseHelper{
//
//   static const _dbName = 'myDatabase.db';
//   static const _dbVersion = 1;
//   static const _tableName = 'likedProducts';
//
//   static const qrDataID = 'id';
//   static const qrDataType = 'name';
//   static const qrDataTime = 'time';
//   static const qrDataInformation = 'information';
//   static const qrDataImage = 'image';
//   static const qrDataFavorite = 'favorite';
//
//   DatabaseHelper._();
//   static final DatabaseHelper instance = DatabaseHelper._();
//
//   static Database? _database;
//
//   Future<Database?> get database async{
//     if(_database != null) return _database;
//
//     _database = await _initiateDatabase();
//     return _database;
//   }
//
//   _initiateDatabase () async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = join(directory.path, _dbName);
//     return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
//   }
//
//   _onCreate(Database db, int version)  {
//     db.execute('''
//     CREATE TABLE $_tableName(
//     $qrDataID INTEGER PRIMARY KEY,
//     $qrDataType TEXT,
//     $qrDataTime TEXT,
//     $qrDataInformation TEXT,
//     $qrDataImage TEXT,
//     $qrDataFavorite TEXT
//     );
//     ''');
//   }
//
//   Future<int> insert(Map<String, dynamic> row) async {
//     Database? db = await instance.database;
//     return db!.insert(_tableName, row);
//   }
//
//   Future<List<Map<String,dynamic>>> queryAll() async {
//     Database? db = await instance.database;
//     return await db!.query(_tableName);
//   }
//
//   Future<List<Map<String,dynamic>>> queryFavorite() async {
//     Database? db = await instance.database;
//     return await db!.query(_tableName,where: '$qrDataFavorite = ?', whereArgs: ['true']);
//   }
//
//   Future<int> update(Map<String,dynamic> row) async {
//     Database? db = await instance.database;
//     int id= row[qrDataID];
//     return await db!.update(_tableName, row,where: '$qrDataID = ?', whereArgs: [id] );
//   }
//
//   Future<int> delete(int id) async {
//     Database? db = await instance.database;
//     return await db!.delete(_tableName,where: '$qrDataID = ?',whereArgs: [id]);
//   }
//
// }