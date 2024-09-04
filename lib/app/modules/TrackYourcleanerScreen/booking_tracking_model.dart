// To parse this JSON data, do
//
//     final bookingTrackingModel = bookingTrackingModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BookingTrackingModel bookingTrackingModelFromJson(String str) => BookingTrackingModel.fromJson(json.decode(str));

String bookingTrackingModelToJson(BookingTrackingModel data) => json.encode(data.toJson());



class BookingTrackingModel {
  int id;
  String address;
  String cleanerName;
  String avatar;
  String price;
  String rating;
  String review;
  String date;
  String cleanerReachedHome;
  String cleanerStartedWork;
  String cleanerCompletedWork;

  BookingTrackingModel({
    required this.id,
    required this.address,
    required this.cleanerName,
    required this.avatar,
    required this.price,
    required this.rating,
    required this.review,
    required this.date,
    required this.cleanerReachedHome,
    required this.cleanerStartedWork,
    required this.cleanerCompletedWork,
  });

  factory BookingTrackingModel.fromJson(Map<String, dynamic> json) => BookingTrackingModel(
    id: json["id"]??"",
    address: json["address"]??"",
    cleanerName: json["cleaner_name"],
    avatar: json["avatar"]??"",
    price: json["price"]??"",
    rating: json["rating"]??"",
    review: json["review"]??"",
    date: json["date"]??"",
    cleanerReachedHome: json["cleaner_reached_home"]??"",
    cleanerStartedWork: json["cleaner_started_work"]??"",
    cleanerCompletedWork: json["cleaner_completed_work"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "cleaner_name": cleanerName,
    "avatar": avatar,
    "price": price,
    "rating": rating,
    "review": review,
    "date": date,
    "cleaner_reached_home": cleanerReachedHome,
    "cleaner_started_work": cleanerStartedWork,
    "cleaner_completed_work": cleanerCompletedWork,
  };
}
