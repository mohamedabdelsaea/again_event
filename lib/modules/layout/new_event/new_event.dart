import 'package:flutter/material.dart';

import '../../../core/theme/app_color.dart';

class NewEvent extends StatelessWidget {
  const NewEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        title: Text(
          'Create Even',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 22,
            color: AppColor.primary,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: AppColor.primary),
        ),
      ),
    );
  }
}
