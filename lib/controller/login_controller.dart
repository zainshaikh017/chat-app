// ignore_for_file: camel_case_types
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';

import '../Session/session_controlar.dart';

class logincontroller with ChangeNotifier{

  final FirebaseAuth _auth=FirebaseAuth.instance;
  bool _loading = false;
  bool get loading=>_loading;
  setloading(bool value){
    _loading=value;
    notifyListeners();
  }

  void login(BuildContext context,String email,String password)async{
   setloading(true);

   try{
     _auth.signInWithEmailAndPassword(
         email: email,
         password: password).then((value) {
       sessionControlar().userid=value.user!.uid.toString();
           setloading(false);
           Navigator.pushReplacementNamed(context, RouteName.dashboardscreen);
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