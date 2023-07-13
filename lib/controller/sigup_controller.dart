
// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/utils.dart';


import '../Session/session_controlar.dart';
class sigup_controller with ChangeNotifier{
  final FirebaseAuth _aut=FirebaseAuth.instance;
  final firestore=FirebaseFirestore.instance.collection('users');
  // DatabaseReference dbref=FirebaseDatabase.instance.ref().child('users');
  bool _loading = false;
  bool get loading=>_loading;
  setloading(bool value){
    _loading=value;
    notifyListeners();
  }

  signup(BuildContext context,String username,String email,String password,) async {
    setloading(true);
    try{
      await _aut.createUserWithEmailAndPassword(
          email: email,
          password: password).then((value){
          sessionControlar().userid=value.user!.uid.toString();
          firestore.doc(value.user!.uid.toString()).set({
            'uid' :value.user!.uid.toString(),
            'email':value.user!.email.toString(),
            'onlinestatues':'',
            'phone':'',
            'username':username,
            'prfile': 'https://cdn.icon-icons.com/icons2/2645/PNG/512/person_circle_icon_159926.png'
          }).


            then((value){
              setloading(false);
              utils.toastmassage('User Created Succesfully');
            }).onError((error, stackTrace){
              utils.toastmassage(error.toString());
            });
        setloading(false);
        utils.toastmassage('User Created Succesfully');
      }).onError((error, stackTrace){
        setloading(false);
        utils.toastmassage(error.toString());
      });
    }catch(e){
      setloading(false);
      utils.toastmassage(e.toString());
    }

  }

}