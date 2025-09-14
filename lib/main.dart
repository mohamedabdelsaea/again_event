import 'package:again_evently/core/routes/app_routes.dart';
import 'package:again_evently/core/routes/page_route_name.dart';
import 'package:again_evently/core/theme/app_color.dart';
import 'package:again_evently/modules/provider/setting_provider.dart';
import 'package:again_evently/modules/splash/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => SettingProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: AppColor.white),
      debugShowCheckedModeBanner: false,
      initialRoute: PageRouteName.newEvent,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
