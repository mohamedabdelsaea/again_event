import 'package:again_evently/core/theme/app_color.dart';
import 'package:again_evently/modules/layout/home/widgets/home_category.dart';
import 'package:again_evently/modules/provider/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_create_tap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<SettingProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.25,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: AppColor.white,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.wb_sunny_outlined,
                              color: AppColor.white,
                            )),
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              'EN',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColor.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Mohamed Abdo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColor.white,
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/map.png',
                          width: 30,
                          height: 30,
                        ),
                        Text(
                          'Cairo , Egypt',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: AppColor.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    DefaultTabController(
                      length: provider.eventCategoryList.length,
                      child: TabBar(
                        isScrollable: true,
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.transparent,
                        tabAlignment: TabAlignment.start,
                        onTap: (index) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        tabs: provider.eventCategoryList.map((category) {
                          return CustomCreateTap(
                            text: category.name,
                            isColor:
                                provider.eventCategoryList.indexOf(category) ==
                                    selectedIndex,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            HomeCategory(),
            SizedBox(height: 20),
            HomeCategory(),
            SizedBox(height: 20),
            HomeCategory(),
            SizedBox(height: 20),
            HomeCategory(),
            SizedBox(height: 20),
            HomeCategory(),
            SizedBox(height: 20),
            HomeCategory(),
          ],
        ),
      ),
    );
  }
}
