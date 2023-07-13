// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_media/Session/session_controlar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_media/utils/utils.dart';

class profile_controlar with ChangeNotifier{


  final firestore=FirebaseFirestore.instance.collection('users');
  firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;

final picker =ImagePicker();
  XFile? _image;
  XFile? get image=> _image;


   Future cameraimage(BuildContext context)async{
     final imagefile= await picker.pickImage(source: ImageSource.camera);
   if(imagefile != null){
     
     _image =XFile(imagefile.path);
     uploadimage(context);
     notifyListeners();
   }
   }

Future galleryimage(BuildContext context)async {
  final imagefile = await picker.pickImage(source: ImageSource.gallery);
  if (imagefile != null) {
    _image = XFile(imagefile.path);
    uploadimage(context);
    notifyListeners();
  }


}


void uploadimage(BuildContext context)async{

     firebase_storage.Reference ref =firebase_storage.FirebaseStorage.instance.
     ref('/profileimage${sessionControlar().userid}');

   firebase_storage.UploadTask uploadTask=ref.putFile( File(image!.path).absolute);



   await Future.value(uploadTask);
   final newurl=await ref.getDownloadURL();
   firestore.doc(sessionControlar().userid.toString())
  .update({
     'prfile': newurl.toString()

   }).then((value) {
     utils.toastmassage("profile update");
   }).onError((error, stackTrace) {
     utils.toastmassage("Error check connection");
   });
   }




  void picimage(context)  {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height:120,
              child: Column(
                children: [
                ListTile(
                  onTap: (){

                    cameraimage(context);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.camera),
                  title: const Text('Camera'),
                ),
                ListTile(
                  onTap: (){

                    galleryimage(context);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.photo),
                  title: const Text('Gallery'),
                ),
              ],),
            ),
          );
        },);
  }




}