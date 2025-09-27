import 'package:again_evently/modules/widget/even_date_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_color.dart';

class HomeCategory extends StatefulWidget {
  EvenDateModel evenDateModel ;
   HomeCategory({super.key, required this.evenDateModel});

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    final _titleController = TextEditingController();
    final _categoryController = TextEditingController();
    return Container(
      height: size.height * 0.25,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage('assets/images/Book Club-3.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              alignment: Alignment.center,
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColor.white,
              ),
              child: Text(
                '17 \n sun',
                style: TextStyle(
                  color: AppColor.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Container(
                width: size.width * 0.85,
                height: 50,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'aaaaaaaaaa',
                      style: TextStyle(
                        color: AppColor.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.favorite_border,
                      color: AppColor.primary,
                      size: 30,
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
