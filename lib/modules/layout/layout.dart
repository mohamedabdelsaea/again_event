import 'package:again_evently/core/routes/page_route_name.dart';
import 'package:again_evently/core/theme/app_color.dart';
import 'package:again_evently/modules/layout/favourite/favourite_screen.dart';
import 'package:again_evently/modules/layout/home/home_screen.dart';
import 'package:again_evently/modules/layout/map/map_screen.dart';
import 'package:again_evently/modules/layout/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  List<Widget> layout = [
    HomeScreen(),
    MapScreen(),
    FavouriteScreen(),
    ProfileScreen(),
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, PageRouteName.newEvent);
        },
        child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: AppColor.primary,
          ),
          child: Icon(Icons.add,color: AppColor.white,),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          fixedColor: AppColor.white,
          showUnselectedLabels: false,
          backgroundColor: AppColor.primary,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/icons/un_Home.png')),
              label: 'Home',
              activeIcon: ImageIcon(AssetImage('assets/icons/Home.png')),
            ),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/un_Map.png')),
                label: 'Home',
                activeIcon: ImageIcon(AssetImage('assets/icons/Map.png'))),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/un_love.png')),
                label: 'Home',
                activeIcon: ImageIcon(AssetImage('assets/icons/love.png'))),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/un_user.png')),
                label: 'Home',
                activeIcon: ImageIcon(AssetImage('assets/icons/user.png'))),
          ]),
      body: layout[selectedIndex],
    );
  }
}
