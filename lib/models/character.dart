import 'package:flutter/material.dart';

class Character {
  String name;
  String image;

  Character({
    @required this.name,
    @required this.image,
  });

  Character.fromJson(Map<String, dynamic> json) {
    this.name = json["name"]["full"];
    this.image = json["image"]["medium"];
  }
}
