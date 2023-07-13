

// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';

import '../../Session/session_controlar.dart';

class splash_services{

  void islogin(BuildContext context){
  FirebaseAuth _auth=FirebaseAuth.instance;
  final user= _auth.currentUser;

    if(user != null){
      sessionControlar().userid=user.uid.toString();
      Timer(const Duration(seconds:3),()=>
          Navigator.pushReplacementNamed(context, RouteName.dashboardscreen)
      );


    }
    else{
    Timer(const Duration(seconds:3),()=>
        Navigator.pushReplacementNamed(context, RouteName.loginview)
    );
    }
  }


}