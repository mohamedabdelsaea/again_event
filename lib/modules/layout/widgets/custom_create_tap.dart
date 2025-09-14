import 'package:flutter/material.dart';

import '/core/theme/app_color.dart';

class CustomCreateTap extends StatelessWidget {
  final String text;
  final bool isColor;

  const CustomCreateTap({
    super.key,
    required this.text,
    required this.isColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isColor ? AppColor.primary : AppColor.white,
          border: Border.all(color: AppColor.primary)),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isColor ? AppColor.white : AppColor.primary),
          ),
        ],
      ),
    );
  }
}
