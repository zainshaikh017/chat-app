import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/fonts.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/routes/routes.dart';

void main()async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: AppColors.primaryMaterialColor,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              color: AppColors.whiteColor,
              centerTitle: true,
              titleTextStyle: TextStyle(
                  fontSize: 22,
                  fontFamily: AppFonts.sfProDisplayMedium,
                  color: AppColors.primaryTextTextColor)),
          textTheme:   const TextTheme(
            displayLarge: TextStyle(
                fontSize: 40,
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w500,
                height: 1.6),
            displayMedium:  TextStyle(
                fontSize: 32,
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w500,
                height: 1.6),
            displaySmall: TextStyle(
                fontSize: 28,
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w500,
                height: 1.9),
            headlineMedium: TextStyle(
                fontSize: 24,
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w500,
                height: 1.6),
            headlineSmall: TextStyle(
                fontSize: 20,
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w500,
                height: 1.6),
            titleLarge: TextStyle(
                fontSize: 17,
                fontFamily: AppFonts.sfProDisplayBold,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w700,
                height: 1.6),
            bodyLarge: TextStyle(
                fontSize: 17,
                fontFamily: AppFonts.sfProDisplayBold,
                color: AppColors.textFieldDefaultFocus,
                fontWeight: FontWeight.w700,
                height: 1.6),
            bodyMedium: TextStyle(
                fontSize: 14,
                fontFamily: AppFonts.sfProDisplayRegular,
                color: AppColors.primaryTextTextColor,
                height: 1.6),
            bodySmall: TextStyle(
                fontSize: 12,
                fontFamily: AppFonts.sfProDisplayBold,
                color: AppColors.primaryTextTextColor,
                height: 2.26),
          )),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}