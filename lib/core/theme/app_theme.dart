import 'package:again_evently/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.white,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.white,
      selectedIconTheme: IconThemeData(color: AppColor.white),
      selectedItemColor: AppColor.white,
      selectedLabelStyle: TextStyle(color: AppColor.white),
      unselectedLabelStyle: TextStyle(color: AppColor.white),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.white,
    ),
    iconTheme: IconThemeData(color: AppColor.white),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.black,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.black,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.black,
      selectedIconTheme: IconThemeData(color: AppColor.black),
      selectedItemColor: AppColor.black,
      selectedLabelStyle: TextStyle(color: AppColor.black),
      unselectedLabelStyle: TextStyle(color: AppColor.black),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.black,
    ),
    iconTheme: IconThemeData(color: AppColor.black),
  );
}
