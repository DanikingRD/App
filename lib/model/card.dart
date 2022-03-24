import 'package:flutter/material.dart';

class TapeaCard {
  final String name;
  final String jobTitle;
  final String company;
  final int color;
  final String? photo;

  TapeaCard({
    required this.name,
    required this.jobTitle,
    required this.company,
    required this.color,
    this.photo,
  });

  factory TapeaCard.fromJson(Map<String, dynamic> json) {
    return TapeaCard(
      name: json["name"],
      jobTitle: json["header"],
      company: json["subtitle"],
      color: json["color"],
      photo: json["photo"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "header": jobTitle,
      "subtitle": company,
      "color": color,
      "photo": photo,
    };
  }

  Color get getColor => Color(color).withOpacity(1);
}
