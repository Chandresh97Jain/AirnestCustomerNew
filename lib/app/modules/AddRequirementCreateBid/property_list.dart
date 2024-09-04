// To parse this JSON data, do
//
//     final propertyListModel = propertyListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class PropertyListModel {
  int id;
  String name;
  String address;
  String propertySize;
  int dontKnowPropertySize;
  String propertyDate;
  String propertyTime;
  String serviceTitle;
  String description;
  String serviceType;
  String latitude;
  String longitude;
  String isBid;
  String isBooked;

  PropertyListModel({
    required this.id,
    required this.name,
    required this.address,
    required this.propertySize,
    required this.dontKnowPropertySize,
    required this.propertyDate,
    required this.propertyTime,
    required this.serviceTitle,
    required this.description,
    required this.serviceType,
    required this.latitude,
    required this.longitude,
    required this.isBid,
    required this.isBooked,
  });

  factory PropertyListModel.fromJson(Map<String, dynamic> json) => PropertyListModel(
    id: json["id"]??"",
    name: json["name"]??"",
    address: json["address"]??"",
    propertySize: json["property_size"]??"",
    dontKnowPropertySize: json["dont_know_property_size"]??"",
    propertyDate: json["property_date"]??"",
    propertyTime: json["property_time"]??"",
    serviceTitle: json["service_title"]??"",
    description: json["description"]??"",
    serviceType: json["service_type"]??"",
    latitude: json["latitude"]??"",
    longitude: json["longitude"]??"",
    isBid: json["is_bid"].toString()??"",
    isBooked: json["is_booked"].toString()??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "property_size": propertySize,
    "dont_know_property_size": dontKnowPropertySize,
    "property_date": propertyDate,
    "property_time": propertyTime,
    "service_title": serviceTitle,
    "description": description,
    "service_type": serviceType,
    "latitude": latitude,
    "longitude": longitude,
    "is_bid": isBid,
    "is_booked": isBooked,
  };
}
