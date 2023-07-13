import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view/forget_password.dart';
import 'package:tech_media/view/signup/sign_up_screen.dart';
import 'package:tech_media/view/splash/splash_screen.dart';

import '../../view/dashboard_screen.dart';
import '../../view/login/login_screen.dart';


class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RouteName.loginview:
        return MaterialPageRoute(builder: (_) =>  const login_screen());
      case RouteName.signupscreen:
        return MaterialPageRoute(builder: (_) =>  const signup_screen());
      case RouteName.forgetpassword:
        return MaterialPageRoute(builder: (_) =>  const forget_password());


    //dashboard
      case RouteName.dashboardscreen:
        return MaterialPageRoute(builder: (_) =>  const dashboard_screen());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}