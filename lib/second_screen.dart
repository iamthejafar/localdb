import 'package:flutter/material.dart';
import 'package:myproject/userDataModel.dart';
import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';
import 'ui_helper.dart';
import 'user_repo.dart';
class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  Database? _database;
  Future<Database?> openDB() async{
    _database = await DataBaseHandler().openDB();
    return _database;
  }

  Future<Database?> insertDB(UserDataModel myDataModel) async{
    _database = await openDB();
    UserRepo userRepo = new UserRepo();
    userRepo.createTable(_database);
    await _database?.insert('User', myDataModel.toMap());
    await _database?.close();
  }

  Future<Database?> getData() async{
    _database = await openDB();
    UserRepo userRepo = new UserRepo();
    await userRepo.getUsers(_database);
    await _database?.close();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder(
              stream: getData(),
              builder: (context,snapshot){

              },
            ),
            ElevatedButton(onPressed: (){getData();}, child: Text('get'))
          ],
        ),
      ),
    );
  }
}
