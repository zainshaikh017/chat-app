// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';

class Round_button extends StatelessWidget {
  const Round_button({Key? key,
    required this.title,
    required this.onpress,
    this.textcolor=AppColors.whiteColor,
    this.color=AppColors.primaryColor,
    this.loading=false
  }) : super(key: key);
  final String title;
  final VoidCallback onpress;
  final Color color,textcolor;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:loading ? null : onpress,
      child: Container (
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color:AppColors.textFieldFocusBorderColor,
          borderRadius: BorderRadius.circular(50)
        ),
        child:loading ? const Center(child: CircularProgressIndicator(
          color: Colors.white,
        )) : Center(child: Text(title,style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 16),)),
      ),
    );
  }
}
