// To parse this JSON data, do
//
//     final servicesListModel = servicesListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

// To parse this JSON data, do
//
//     final servicesListModel = servicesListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class ServicesListModel {
  int id;
  String title;
  String icon;
  String priceLabelId;
  int isActive;
  dynamic priceLabelText;

  ServicesListModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.priceLabelId,
    required this.isActive,
    required this.priceLabelText,
  });

  factory ServicesListModel.fromJson(Map<String, dynamic> json) => ServicesListModel(
    id: json["id"],
    title: json["title"],
    icon: json["icon"],
    priceLabelId: json["price_label_id"],
    isActive: json["is_active"],
    priceLabelText: json["price_label_text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "icon": icon,
    "price_label_id": priceLabelId,
    "is_active": isActive,
    "price_label_text": priceLabelText,
  };
}

enum PriceLabelTextElement {
  BATHROOM,
  BEDROOM,
  PER_HOUR
}

final priceLabelTextElementValues = EnumValues({
  "Bathroom": PriceLabelTextElement.BATHROOM,
  "Bedroom": PriceLabelTextElement.BEDROOM,
  "Per Hour": PriceLabelTextElement.PER_HOUR
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}



class ServicesTypeModel {
  int id;
  String title;


  ServicesTypeModel({
    required this.id,
    required this.title,
  });

  factory ServicesTypeModel.fromJson(Map<String, dynamic> json) => ServicesTypeModel(
    id: json["id"],
    title: json["title"]??"",
 );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,

  };
}
