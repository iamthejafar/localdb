import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHandler{
  static final DataBaseHandler _dataBaseHandler = DataBaseHandler._internal();

  static Database? _database;

  factory DataBaseHandler(){
    return _dataBaseHandler;
  }

  DataBaseHandler._internal();
  Future<Database?> openDB() async{
    _database = await openDatabase(
      join(await getDatabasesPath(), 'user1.db')
    );
    return _database;
  }

}