import 'package:again_evently/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: AppColor.white,
            centerTitle: true,
            title: Text(
              'Soon Map',
              style: TextStyle(
                color: AppColor.primary,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(height: 200),
          Center(
            child: Icon(
              Icons.timelapse_outlined,
              size: 80,
              color: AppColor.primary,
            ),
          ),
        ],
      ),
    );
  }
}
