import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:developer';
import 'package:again_evently/core/routes/page_route_name.dart';
import 'package:again_evently/modules/provider/setting_provider.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userName ;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  getCurrentUser(){
    final user = FirebaseAuth.instance.currentUser ;
    setState(() {
      userName = user?.email ?? 'User' ;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var local = AppLocalizations.of(context)!;
    var provider = Provider.of<SettingProvider>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height * 0.14,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(26))),
            child: Text(
              userName ?? 'User',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColor.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Text(
              local.language,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColor.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomDropdown<String>(
              items: provider.language,
              initialItem: provider.currentLanguage,
              hintText: local.language,
              decoration: CustomDropdownDecoration(
                closedSuffixIcon:
                    Icon(Icons.arrow_drop_down, color: AppColor.primary),
                expandedSuffixIcon:
                    Icon(Icons.arrow_drop_down, color: AppColor.primary),
                closedBorderRadius: BorderRadius.circular(12),
                closedBorder: Border.all(color: AppColor.primary),
                hintStyle: TextStyle(color: AppColor.primary, fontSize: 16),
              ),
              onChanged: (value) {
                if (value != null) {
                  provider.setLanguage(value);
                }
              },
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Text(
              local.theme,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColor.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomDropdown(
              items: provider.theme,
              hintText: local.theme,
              decoration: CustomDropdownDecoration(
                  closedSuffixIcon: Icon(
                    Icons.arrow_drop_down,
                    color: AppColor.primary,
                  ),
                  expandedSuffixIcon: Icon(
                    Icons.arrow_drop_down,
                    color: AppColor.primary,
                  ),
                  closedBorderRadius: BorderRadius.circular(12),
                  closedBorder: Border.all(color: AppColor.primary),
                  hintStyle: TextStyle(color: AppColor.primary, fontSize: 16)),
              onChanged: (value) {
                if (value == 'Light') {
                  provider.setCurrentTheme(ThemeMode.light);
                } else if (value == 'Dark'){
                  provider.setCurrentTheme(ThemeMode.dark);
                }
              },
            ),
          ),
          SizedBox(height: size.height * 0.2),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  PageRouteName.signIn,
                  (route) => false,
                );
              },
              child: Container(
                height: size.height * 0.08,
                width: size.width * 0.9,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(14)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(Icons.logout, color: AppColor.white),
                    ),
                    Text(
                      local.logout,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                        color: AppColor.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
