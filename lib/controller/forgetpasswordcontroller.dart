


// ignore_for_file: avoid_single_cascade_in_expression_statements, camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils.dart';
class forgetpasswordcontroller with ChangeNotifier{

  final FirebaseAuth _auth=FirebaseAuth.instance;
  bool _loading = false;
  bool get loading=>_loading;
  setloading(bool value){
    _loading=value;
    notifyListeners();
  }

  void forgetpassword(BuildContext context,String email,)async{
    setloading(true);

    try{
      _auth..sendPasswordResetEmail(
          email: email,
          ).then((value) {

        setloading(false);
        Navigator.pushNamed(context, RouteName.loginview);
        utils.toastmassage('Check your email to recover your password');
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