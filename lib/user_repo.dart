import 'package:sqflite/sqflite.dart';


class UserRepo{
  void createTable(Database? db){
    db?.execute('CREATE TABLE IF NOT EXISTS USER(id INTEGER PRIMARY KEY, name TEXT, city CITY, hobbies TEXT, contacts TEXT, gender TEXT)');
  }
  Future<void> getUsers(Database? db) async{
    final List<Map<String,dynamic>> maps = await db!.query('User');
    print(maps);
  }
}