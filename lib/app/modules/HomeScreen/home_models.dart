// To parse this JSON data, do
//
//     final nearByListModel = nearByListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

// To parse this JSON data, do
//
//     final nearByListModel = nearByListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';


class NearByListModel {
  int id;
  String cleanerName;
  int role;
  String avatar;
  String firebaseId;
  // String address;
  String address2;
  String latitude;
  String longitude;
  String rating;
  String review;
  int isFavorite;

  NearByListModel({
    required this.id,
    required this.cleanerName,
    required this.role,
    required this.avatar,
    required this.firebaseId,
    // required this.address,
    required this.address2,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.review,
    required this.isFavorite,
  });

  factory NearByListModel.fromJson(Map<String, dynamic> json) => NearByListModel(
    id: json["id"],
    cleanerName: json["cleaner_name"],
    role: json["role"],
    avatar: json["avatar"],
    firebaseId: json["firebase_id"]??"",
    // address: json["address"],
    address2: json["address2"]??"",
    latitude: json["latitude"],
    longitude: json["longitude"],
    rating: json["rating"],
    review: json["review"],
    isFavorite: json["is_favorite"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cleaner_name": cleanerName,
    "role": role,
    "avatar": avatar,
    "firebase_id": firebaseId,
    // "address": address,
    "address2": address2,
    "latitude": latitude,
    "longitude": longitude,
    "rating": rating,
    "review": review,
    "is_favorite": isFavorite,
  };
}


class RecommendedListModel {
  int id;
  String cleanerName;
  int role;
  String avatar;
  String rating;
  String review;
  // String address;
  String address2;
  int isFavorite;
  String firebaseId;

  RecommendedListModel({
    required this.id,
    required this.cleanerName,
    required this.role,
    required this.avatar,
    required this.rating,
    required this.review,
    // required this.address,
    required this.address2,
    required this.isFavorite,
    required this.firebaseId,
  });

  factory RecommendedListModel.fromJson(Map<String, dynamic> json) => RecommendedListModel(
    id: json["id"],
    cleanerName: json["cleaner_name"],
    role: json["role"],
    avatar: json["avatar"],
    rating: json["rating"],
    review: json["review"],
    // address: json["address"]??"",
    address2: json["address2"]??"",
    isFavorite: json["is_favorite"],
    firebaseId: json["firebase_id"]??'',

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cleaner_name": cleanerName,
    "role": role,
    "avatar": avatar,
    "rating": rating,
    "review": review,
    // "address": address,
    "address2": address2,
    "is_favorite": isFavorite,
    "firebase_id": firebaseId,
  };
}


class FaviouriteListModel {
  int id;
  String cleanerName;
  int role;
  String avatar;
  // String address;
  String address2;
  String rating;
  String review;
  int isFavorite;
  String firebaseId;

  FaviouriteListModel({
    required this.id,
    required this.cleanerName,
    required this.role,
    required this.avatar,
    // required this.address,
    required this.address2,
    required this.rating,
    required this.review,
    required this.isFavorite,
    required this.firebaseId,
  });

  factory FaviouriteListModel.fromJson(Map<String, dynamic> json) => FaviouriteListModel(
    id: json["id"],
    cleanerName: json["cleaner_name"]??"",
    role: json["role"]??"",
    avatar: json["avatar"]??"",
    // address: json["address"]??"",
    address2: json["address2"]??"",
    rating: json["rating"],
    review: json["review"],
    isFavorite: json["is_favorite"],
    firebaseId: json["firebase_id"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cleaner_name": cleanerName,
    "role": role,
    "avatar": avatar,
    // "address": address,
    "address2": address2,
    "rating": rating,
    "review": review,
    "is_favorite": isFavorite,
    "firebase_id": firebaseId,
  };
}

