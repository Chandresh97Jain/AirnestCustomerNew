// To parse this JSON data, do
//
//     final cleanerCoHostListModel = cleanerCoHostListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CleanerCoHostListModel {
  int id;
  String firstname;
  String lastname;
  String username;
  String email;
  String mobile;
  String address;
  String avatar;
  String experience;
  String repeatClient;
  String responseRate;
  String rating;
  String review;
  String hourlyRate;
  String firebaseId;

  CleanerCoHostListModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.mobile,
    required this.address,
    required this.avatar,
    required this.experience,
    required this.repeatClient,
    required this.responseRate,
    required this.rating,
    required this.review,
    required this.hourlyRate,
    required this.firebaseId,
  });

  factory CleanerCoHostListModel.fromJson(Map<String, dynamic> json) => CleanerCoHostListModel(
    id: json["id"],
    firstname: json["firstname"]??"",
    lastname: json["lastname"]??"",
    username: json["username"]??"",
    email: json["email"]??"",
    mobile: json["mobile"]??"",
    address: json["address"]??"",
    avatar: json["avatar"]??'',
    experience: json["experience"]??'',
    repeatClient: json["repeat_client"]??'',
    responseRate: json["response_rate"]??"",
    rating: json["rating"]??'',
    review: json["review"]??'',
    hourlyRate: json["hourly_rate"]??"",
    firebaseId: json["firebase_id"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "username": username,
    "email": email,
    "mobile": mobile,
    "address": address,
    "avatar": avatar,
    "experience": experience,
    "repeat_client": repeatClient,
    "response_rate": responseRate,
    "rating": rating,
    "review": review,
    "hourly_rate": hourlyRate,
    "firebase_id": firebaseId,
  };
}
