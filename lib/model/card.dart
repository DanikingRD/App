import 'package:flutter/material.dart';

class TapeaCard {
  final String title;
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String company;
  final int color;
  final String? photo;

  TapeaCard({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    required this.company,
    required this.color,
    this.photo,
  });

  factory TapeaCard.fromJson(Map<String, dynamic> json) {
    return TapeaCard(
      title: json["title"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      jobTitle: json["header"],
      company: json["subtitle"],
      color: json["color"],
      photo: json["photo"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "firstName": firstName,
      "lastName": lastName,
      "header": jobTitle,
      "subtitle": company,
      "color": color,
      "photo": photo,
    };
  }

  Color get getColor => Color(color).withOpacity(1);

  @override
  String toString() {
    return 'TapeaCard(title: $title, firstName: $firstName, lastName: $lastName, jobTitle: $jobTitle, company: $company, color: $color, photo: $photo)';
  }
}
