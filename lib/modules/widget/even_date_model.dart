import 'package:flutter/material.dart';

class EvenDateModel {
  late final String Id;
  final String title;
  final String image;
  final String category;
  final DateTime dateTime;
  final TimeOfDay timeOfDay;
  bool isFavourite = false;

  EvenDateModel({
    required this.Id,
    required this.title,
    required this.image,
    required this.category,
    required this.dateTime,
    required this.timeOfDay,
  });

  factory EvenDateModel.fromFireStore(Map<String, dynamic> json) =>
      EvenDateModel(
        Id: json['Id'],
        title: json['title'],
        image: json['image'],
        category: json['category'],
        dateTime: json['dateTime'],
        timeOfDay: json['timeOfDay'],
      );

  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'title': title,
      'image': image,
      'category': category,
      'dateTime': dateTime,
      'timeOfDay': timeOfDay,
    };
  }
}
