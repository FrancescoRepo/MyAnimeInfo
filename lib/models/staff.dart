import 'package:flutter/material.dart';

class Staff {
  String name;
  String image;

  Staff({
    @required this.name,
    @required this.image,
  });

  Staff.fromJson(Map<String, dynamic> json) {
    this.name = json["name"]["full"];
    this.image = json["image"]["medium"];
  }
}
