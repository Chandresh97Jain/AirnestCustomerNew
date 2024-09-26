// To parse this JSON data, do
//
//     final cleanerListByBidModel = cleanerListByBidModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CleanerListByBidModel {
  int id;
  int bidId;
  String price;
  int serviceId;
  String serviceName;
  int propertyId;
  String propertyZipcode;
  String address2;
  int cleanerRole;
  String cleanerAbout;
  String cleanerAddress;
  String cleanerName;
  String firebaseId;
  String location;
  String about;
  String memberSince;
  String platformFee;
  int airnestsWorks;
  String avatar;
  String rating;
  String review;
  int cleanerId;
  String bidTime;
  String bidDate;

  CleanerListByBidModel({
    required this.id,
    required this.bidId,
    required this.price,
    required this.serviceId,
    required this.serviceName,
    required this.propertyId,
    required this.propertyZipcode,
    required this.address2,
    required this.cleanerRole,
    required this.cleanerAbout,
    required this.cleanerAddress,
    required this.cleanerName,
    required this.firebaseId,
    required this.location,
    required this.about,
    required this.memberSince,
    required this.platformFee,
    required this.airnestsWorks,
    required this.avatar,
    required this.rating,
    required this.review,
    required this.cleanerId,
    required this.bidTime,
    required this.bidDate,
  });

  factory CleanerListByBidModel.fromJson(Map<String, dynamic> json) => CleanerListByBidModel(
    id: json["id"],
    bidId: json["bid_id"],
    price: json["price"],
    serviceId: json["service_id"],
    serviceName: json["service_name"],
    propertyId: json["property_id"],
    propertyZipcode: json["property_zipcode"],
    address2: json["address2"]??"",
    cleanerRole: json["cleaner_role"],
    cleanerAbout: json["cleaner_about"],
    cleanerAddress: json["cleaner_address"],
    cleanerName: json["cleaner_name"],
    firebaseId: json["firebase_id"]??"",
    location: json["location"],
    about: json["about"],
    memberSince: json["member_since"],
    platformFee: json["platform_fee"],
    airnestsWorks: json["airnests_works"],
    avatar: json["avatar"],
    rating: json["rating"],
    review: json["review"],
    cleanerId: json["cleaner_id"],
    bidTime: json["bid_time"],
    bidDate: json["bid_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bid_id": bidId,
    "price": price,
    "service_id": serviceId,
    "service_name": serviceName,
    "property_id": propertyId,
    "property_zipcode": propertyZipcode,
    "address2": address2,
    "cleaner_role": cleanerRole,
    "cleaner_about": cleanerAbout,
    "cleaner_address": cleanerAddress,
    "cleaner_name": cleanerName,
    "firebase_id": firebaseId,
    "location": location,
    "about": about,
    "member_since": memberSince,
    "platform_fee": platformFee,
    "airnests_works": airnestsWorks,
    "avatar": avatar,
    "rating": rating,
    "review": review,
    "cleaner_id": cleanerId,
    "bid_time": bidTime,
    "bid_date": bidDate,
  };
}
