import 'package:again_evently/core/routes/page_route_name.dart';
import 'package:again_evently/modules/layout/layout.dart';
import 'package:again_evently/modules/sign_in/sign_in.dart';
import 'package:again_evently/modules/sign_up/sign_up.dart';
import 'package:again_evently/modules/splash/splashScreen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case PageRouteName.initial:
        return MaterialPageRoute(builder: (context) => Splashscreen());
      case PageRouteName.layout:
        return MaterialPageRoute(builder: (context) => Layout());
      case PageRouteName.signIn:
        return MaterialPageRoute(builder: (context) => SignIn());
      case PageRouteName.signUp:
        return MaterialPageRoute(builder: (context) => SignUp());
      default:
        return MaterialPageRoute(
          builder: (context) => Splashscreen(),
        );
    }
  }
}
