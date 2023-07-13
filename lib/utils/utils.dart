


// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../res/color.dart';

class utils{

  static void fieldFocus(
      BuildContext context,
      FocusNode currentNode,
      FocusNode nextFocus
      ){
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }


  static toastmassage(String massage){

    Fluttertoast.showToast(
        msg: massage,
    backgroundColor: AppColors.primaryTextTextColor,
      textColor: AppColors.whiteColor

    );
  }


}