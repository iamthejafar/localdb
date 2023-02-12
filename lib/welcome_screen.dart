import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myproject/second_screen.dart';
import 'package:myproject/userDataModel.dart';
import 'package:myproject/user_repo.dart';
import 'ui_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? _selectedGender;
  String _selectedCity = 'Surat';
  bool? _sportChecked = false;
  bool? _readChecked = false;
  bool? _singChecked = false;

  List<String> city  = ['Surat','Vadodara', 'Bharuch', 'Ahemedabad', 'Pune', 'Banglore'];
  List<String> contactOptions = ['Mobile No', 'Email', 'Fax', 'Telephone'];

  String _selectedContactOption = 'Mobile No';

  Map<String,dynamic> contactsMap={};
  Map<String,dynamic> hobbiesMap={};

  // Uint8List? uint8List = UiHelper().convertBase64ToUint8List(UiHelper().getBase64String());
  TextEditingController nameController = TextEditingController();

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
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Form(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal:20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Container(
                //   margin: EdgeInsets.symmetric(vertical: 15),
                //   child: CircleAvatar(
                //     // backgroundImage: uint8List!=null?Image.memory(uint8List!).image:null,
                //     radius: 70.0,
                //     child: GestureDetector(
                //       onTap: (){
                //         setState(() {
                //           UiHelper().showPhotoDialog(context);
                //         });
                //       },
                //       child: Icon(Icons.person,size: 70.0,),
                //     ),
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Enter Name',
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      CustomRadioButton('Male'),
                      CustomRadioButton('Female'),
                      CustomRadioButton('Other')
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: CustomCheckBoxList(),
                ),

                Container(
                  margin: EdgeInsets.all(5),
                  child: DropdownButtonFormField(
                      items: city.map<DropdownMenuItem<String>>((String cityname){
                        return DropdownMenuItem(
                          value: cityname,
                          child: Text(cityname),
                        );
                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          _selectedCity = value!;
                        });
                      },
                    value: _selectedCity,
                  ),
                ),

                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 50.0,
                        width: 100.0,
                        child: DropdownButtonFormField(
                          items: contactOptions.map<DropdownMenuItem<String>>((String option){
                            return DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          onChanged: (value){
                            setState(() {
                              _selectedContactOption = value!;
                            });
                          },
                          value: _selectedContactOption,
                        ),
                      ),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left: 5),
                              height: 46.0,
                              child: TextFormField(
                                onChanged: (value){
                                  setState(() {
                                    contactsMap.addEntries([
                                      MapEntry(_selectedContactOption.toString(), value.toString())
                                    ]
                                    );
                                  });

                                },
                                decoration: InputDecoration(
                                  hintText: 'Enter $_selectedContactOption'
                                ),
                              )
                          )
                      )
                    ],
                  ),
                ),

                ElevatedButton(
                    onPressed: (){
                      String hobbiesMapJsonString = jsonEncode(hobbiesMap);
                      String contactsMapJsonString = jsonEncode(contactsMap);

                      UserDataModel newUserDataModel = UserDataModel(
                        name: nameController.text.toString(),
                        gender: _selectedGender,
                        hobbies: hobbiesMapJsonString,
                        contacts: contactsMapJsonString
                      );

                      insertDB(newUserDataModel);





                    },
                    child: Text('Submit')
                ),
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondScreen()));
                      getData();

                      }, child: Text('Grt')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget CustomRadioButton(String gender){
    return  Row(
      children: [
        Text('$gender'),
        Radio(
          value: '$gender',
          groupValue: _selectedGender,
          onChanged: (value){
            setState(() {
              _selectedGender = value;
            });
          },
        ),
      ],
    );
  }
  Widget CustomCheckBoxList(){
    return  Row(
      children: [
        Text('Sport'),
        Checkbox(
          value: _sportChecked,
          onChanged: (value){
            setState(() {
              _sportChecked = value;
              hobbiesMap.addEntries([
                MapEntry('Sport', value)
              ]);
            });
          },
        ),
        Text('Reading'),
        Checkbox(
          value: _readChecked,
          onChanged: (value){
            setState(() {
              _readChecked = value;
              hobbiesMap.addEntries([
                MapEntry('Reading', value)
              ]);
            });

          },
        ),
        Text('Singing'),
        Checkbox(
          value: _singChecked,
          onChanged: (value){
            setState(() {
              _singChecked = value;
              hobbiesMap.addEntries([
                MapEntry('Singing', value)
              ]);
            });
          },
        )
      ],
    );
  }
}


