import 'package:again_evently/core/theme/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Map',
          style: theme.displayMedium,
        ),
      ),
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Soon',
              style: theme.displayMedium,
            ),
            SizedBox(width: 20),
            Icon(
              Icons.recycling,
              color: AppColor.primary,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
