// To parse this JSON data, do
//
//     final blogListModel = blogListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';


class BlogListModel {
  int id;
  String title;
  String image;
  String shortDescription;

  BlogListModel({
    required this.id,
    required this.title,
    required this.image,
    required this.shortDescription,
  });

  factory BlogListModel.fromJson(Map<String, dynamic> json) => BlogListModel(
    id: json["id"],
    title: json["title"]??"",
    image: json["image"]??"",
    shortDescription: json["short_description"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "short_description": shortDescription,
  };
}
