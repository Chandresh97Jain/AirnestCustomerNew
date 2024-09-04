// To parse this JSON data, do
//
//     final bookingDetailModel = bookingDetailModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';



class BookingDetailModel {
  int id;
  String address;
  String bookingDate;
  String bookingTime;
  String cleanerName;
  String avatar;
  String cleanerFirebaseId;
  String description;
  String price;
  String rating;
  String review;
  String cardHolderName;
  String cardNumber;
  String adminCommission;

  BookingDetailModel({
    required this.id,
    required this.address,
    required this.bookingDate,
    required this.bookingTime,
    required this.cleanerName,
    required this.avatar,
    required this.cleanerFirebaseId,
    required this.description,
    required this.price,
    required this.rating,
    required this.review,
    required this.cardHolderName,
    required this.cardNumber,
    required this.adminCommission,
  });

  factory BookingDetailModel.fromJson(Map<String, dynamic> json) => BookingDetailModel(
    id: json["id"],
    address: json["address"]??"",
    bookingDate: json["booking_date"]??"",
    bookingTime: json["booking_time"]??'',
    cleanerName: json["cleaner_name"]??'',
    avatar: json["avatar"]??'',
    cleanerFirebaseId: json["cleaner_firebase_id"]??'',
    description: json["description"]??'',
    price: json["price"]??'',
    rating: json["rating"]??'',
    review: json["review"]??'',
    cardHolderName: json["card_holder_name"]??'',
    cardNumber: json["card_number"]??'',
    adminCommission: json["admin_commission"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "booking_date": bookingDate,
    "booking_time": bookingTime,
    "cleaner_name": cleanerName,
    "avatar": avatar,
    "cleaner_firebase_id": cleanerFirebaseId,
    "description": description,
    "price": price,
    "rating": rating,
    "review": review,
    "card_holder_name": cardHolderName,
    "card_number": cardNumber,
    "admin_commission": adminCommission,
  };
}

