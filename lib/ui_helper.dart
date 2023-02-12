import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UiHelper{
   File? imagefile;
   String? path;
    showPhotoDialog(BuildContext context){
      showDialog(context: context, builder: (context){
      return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
          ),
          title: Text('Upload Profile Pic'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: (){
                  Navigator.pop(context);
                  selectImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_album),
                title: Text('Gallery'),
                onTap: (){
                  Navigator.pop(context);
                  selectImage(ImageSource.gallery);
                },
              )
            ],
          )
      );
      });
    }

    selectImage(ImageSource source) async{
      XFile ? pickedFile = await ImagePicker().pickImage(source: source);
      this.imagefile = File(pickedFile!.path);
      print(imagefile);
      setImageFile(imagefile);
    }

     setImageFile(var image){
      imagefile = image;
      print('$imagefile 2nd time');
    }



    // String getBase64String(){
    //   print('this is $imagefile');
    //   // List<int> imageBytes = imagefile!.readAsBytesSync();
    //   // String base64Image = base64Encode(imageBytes);
    //   // return base64Image;
    //   return '';
    // }


    //
    // Uint8List convertBase64ToUint8List(String base64){
    //   Uint8List imageUint8 = base64Decode(base64);
    //   return imageUint8;
    // }
}