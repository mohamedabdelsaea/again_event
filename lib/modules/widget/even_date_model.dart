import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EvenDateModel {
  String Id;
  final String title;
  final String image;
  final String category;
  final DateTime dateTime;
  final TimeOfDay timeOfDay;
  bool isFavourite;

  EvenDateModel({
    required this.Id,
    required this.title,
    required this.image,
    required this.category,
    required this.dateTime,
    required this.timeOfDay,
    this.isFavourite = false,
  });

  factory EvenDateModel.fromFireStore(Map<String, dynamic> json) {
    return EvenDateModel(
      Id: json['Id'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      category: json['category'] ?? '',
      dateTime: (json['dateTime'] as Timestamp).toDate(),
      timeOfDay: _parseTimeOfDay(json['timeOfDay']),
      isFavourite: json['isFavourite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'title': title,
      'image': image,
      'category': category,
      'dateTime': Timestamp.fromDate(dateTime),
      'timeOfDay': '${timeOfDay.hour}:${timeOfDay.minute}',
      'isFavourite': isFavourite,
    };
  }

  static TimeOfDay _parseTimeOfDay(String time) {
    final parts = time.split(":");
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }
}
