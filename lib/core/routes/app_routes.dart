import 'package:again_evently/core/routes/page_route_name.dart';
import 'package:again_evently/modules/forget_password/forget_password.dart';
import 'package:again_evently/modules/layout/layout.dart';
import 'package:again_evently/modules/layout/new_event/new_event.dart';
import 'package:again_evently/modules/sign_in/sign_in.dart';
import 'package:again_evently/modules/sign_up/sign_up.dart';
import 'package:again_evently/modules/splash/splashScreen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case PageRouteName.initial:
        return MaterialPageRoute(builder: (context) => const Splashscreen());
      case PageRouteName.layout:
        return MaterialPageRoute(builder: (context) => const Layout());
      case PageRouteName.signIn:
        return MaterialPageRoute(builder: (context) => const SignIn());
      case PageRouteName.signUp:
        return MaterialPageRoute(builder: (context) => const SignUp());
      case PageRouteName.forgetPassword:
        return MaterialPageRoute(builder: (context) => const ForgetPassword());
     case PageRouteName.newEvent:
        return MaterialPageRoute(builder: (context) => const NewEvent());
      default:
        return MaterialPageRoute(
          builder: (context) => const Splashscreen(),
        );
    }
  }
}
