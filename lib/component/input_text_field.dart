// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';

class inputtextfield extends StatelessWidget {
  const inputtextfield({Key? key,
    required this.mycontroller,
    required this.focusNode,
    required this.onfiledsubmittedvalue,
    required this.onvalidator,
    required this.keyboardtype,
    required this.hint,
    required this.obscuretext,
    this.enable =true,
    this.autofocus =false
  }) : super(key: key);


  final TextEditingController mycontroller;
  final FocusNode focusNode;
  final FormFieldSetter onfiledsubmittedvalue;
  final FormFieldValidator onvalidator;

  final TextInputType keyboardtype;
  final String hint;
  final bool obscuretext;
  final bool enable,autofocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: mycontroller,
        focusNode: focusNode,
        onFieldSubmitted: onfiledsubmittedvalue,
        validator: onvalidator,
        keyboardType: keyboardtype,
        obscureText: obscuretext,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.textFieldDefaultFocus,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.secondaryColor,
              ),
              borderRadius: BorderRadius.circular(8),
            ),

            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.alertColor,
              ),
              borderRadius: BorderRadius.circular(8),
            ),

            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.textFieldDefaultBorderColor,
              ),
              borderRadius: BorderRadius.circular(8),
            ),

          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodySmall
        ),

      ),
    );
  }
}
