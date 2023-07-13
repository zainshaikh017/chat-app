
import 'package:flutter/material.dart';
import 'package:tech_media/res/fonts.dart';
import 'package:tech_media/view/services/splash_services.dart';

import '../../res/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  splash_services serivces = splash_services();
   @override
  void initState() {
    super.initState();
   serivces.islogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
             Image(
                 width: 150,
                 height: 150,
                 image: AssetImage('assets/images/chatlogo.png')),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 20),
                child: Center(child: Text('Chat-App' ,
                  style: TextStyle(
                      fontFamily: AppFonts.sfProDisplayBold ,
                      fontSize: 40,
                      fontWeight: FontWeight.w700
                  ),)),
              ),

            ],
          )
      ),

      bottomNavigationBar: Container(
        color: Colors.cyan.shade300,
        height: 40,
        child: Center(
            child: Text('Build by \'zain shaikh\'' ,
              style: TextStyle(
                  color: AppColors.textFieldDefaultFocus,
                  fontFamily: AppFonts.sfProDisplayBold ,
                  fontSize: 15,
                  fontWeight: FontWeight.w700
              ),)),
      ),
    );
  }
}
