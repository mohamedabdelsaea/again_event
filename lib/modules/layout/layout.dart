import 'package:again_evently/core/routes/page_route_name.dart';
import 'package:again_evently/core/theme/app_color.dart';
import 'package:again_evently/modules/provider/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    var provider = Provider.of<SettingProvider>(context);
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
          child: Icon(
            Icons.add,
          ),
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
          showUnselectedLabels: false,
          backgroundColor: AppColor.primary,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/icons/un_Home.png')),
              label: local.home,
              activeIcon: ImageIcon(AssetImage('assets/icons/Home.png')),
            ),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/un_Map.png')),
                label: local.map,
                activeIcon: ImageIcon(AssetImage('assets/icons/Map.png'))),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/un_love.png')),
                label: local.favourite,
                activeIcon: ImageIcon(AssetImage('assets/icons/love.png'))),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/un_user.png')),
                label: local.profile,
                activeIcon: ImageIcon(AssetImage('assets/icons/user.png'))),
          ]),
      body: provider.layout[selectedIndex],
    );
  }
}
