import 'dart:developer';

import 'package:again_evently/core/routes/page_route_name.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<String> language = [
      'Arabic',
      'English',
    ];
    List<String> theme = [
      'Light',
      'Dark',
    ];
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height * 0.18,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(26))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: Text(
                    'Mohamed Abdo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColor.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Text(
                    'Mohamed.Abdo@gmail.com',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Text(
              'Language',
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
              items: language,
              hintText: 'Language',
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
                log('$language');
              },
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Text(
              'Theme',
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
              items: theme,
              hintText: 'Theme',
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
                log('$language');
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
                      'Logout',
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
