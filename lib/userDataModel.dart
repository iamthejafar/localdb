
class UserDataModel{
  // String? image;
  String? name;
  String? gender;
  String? hobbies;
  String? contacts;

  UserDataModel({this.name,this.gender,this.hobbies,this.contacts});

  UserDataModel.fromMap(Map<String,dynamic> map){
    name = map['name'];
    gender = map['gender'];
    hobbies = map['hobbies'];
    contacts = map['contacts'];
  }



  Map<String,dynamic> toMap(){
    return {
      'name' : name,
      'gender' : gender,
      'hobbies' : hobbies,
      'contacts' : contacts
    };
  }

}