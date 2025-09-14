import 'package:again_evently/modules/layout/widgets/event_category.dart';
import 'package:flutter/material.dart';
import '../layout/favourite/favourite_Screen.dart';
import '../layout/home/home_screen.dart';
import '../layout/map/map_screen.dart';
import '../layout/profile/profile_screen.dart';

class SettingProvider extends ChangeNotifier {

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
    EventCategory(name: 'Eating', img: 'assets/images/Book Club-1.png'
    ),
    EventCategory(name: 'Work Shop', img: 'assets/images/Book Club-2.png'
    ),
    EventCategory(name: 'Holiday', img: 'assets/images/Book Club-3.png'
    ),
    EventCategory(name: 'Gaming', img: 'assets/images/Book Club-4.png'
    ),
    EventCategory(name: 'Meeting', img: 'assets/images/Book Club-5.png'
    ),
    EventCategory(name: 'BirthDay', img: 'assets/images/Book Club-6.png'
    ),
    EventCategory(name: 'Sport', img: 'assets/images/Book Club-7.png'
    ),
    EventCategory(name: 'Exhihition', img: 'assets/images/Book Club-8.png'
    ),
  ];


  List<EventCategory> get eventCategoryList => _eventCategoryList;

  List<String> get language => _language;

  List<String> get theme => _theme;

  List<Widget> get layout => _layout;
}
