import 'dart:developer';
import 'package:again_evently/modules/layout/widgets/event_category.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../layout/favourite/favourite_Screen.dart';
import '../layout/home/home_screen.dart';
import '../layout/map/map_screen.dart';
import '../layout/profile/profile_screen.dart';

class SettingProvider extends ChangeNotifier {
  DateTime? _selectedDate;
  TimeOfDay? _timeOfDay;
  String currantLanguage = 'en';


  List<String> _language = [
    'Arabic',
    'English',
  ];
  List<String> _theme = [
    'Light',
    'Dark',
  ];
  List<Widget> _layout = [
    HomeScreen(),
    MapScreen(),
    FavouriteScreen(),
    ProfileScreen(),
  ];
  List<EventCategory> _eventCategoryList = [
    EventCategory(name: 'Book', img: 'assets/images/Book Club.png'),
    EventCategory(name: 'Eating', img: 'assets/images/Book Club-1.png'),
    EventCategory(name: 'Work Shop', img: 'assets/images/Book Club-2.png'),
    EventCategory(name: 'Holiday', img: 'assets/images/Book Club-3.png'),
    EventCategory(name: 'Gaming', img: 'assets/images/Book Club-4.png'),
    EventCategory(name: 'Meeting', img: 'assets/images/Book Club-5.png'),
    EventCategory(name: 'BirthDay', img: 'assets/images/Book Club-6.png'),
    EventCategory(name: 'Sport', img: 'assets/images/Book Club-7.png'),
    EventCategory(name: 'Exhihition', img: 'assets/images/Book Club-8.png'),
  ];

  DateTime? get selectedDate => _selectedDate;

  TimeOfDay? get timeOfDay => _timeOfDay;

  List<EventCategory> get eventCategoryList => _eventCategoryList;

  List<String> get language => _language;

  List<String> get theme => _theme;

  List<Widget> get layout => _layout;

  bool isEnglish() {
    return currantLanguage == 'en';
  }

  selectedEvenDate(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (newDate != null) {
      _selectedDate = newDate;
      notifyListeners();
    }
    log('$_selectedDate');
  }

  selectedDateTime(BuildContext context) async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null) {
      _timeOfDay = newTime;
      notifyListeners();
    }
    log('$_timeOfDay');
  }

  setLanguage(String newLanguage) async {
    if (newLanguage == currantLanguage) return;
    currantLanguage = newLanguage;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('lang', newLanguage);
    notifyListeners();
  }
}
