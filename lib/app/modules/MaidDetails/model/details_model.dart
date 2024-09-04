// To parse this JSON data, do
//
//     final detailsModel = detailsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class AboutDetails {
  String about;

  AboutDetails({
    required this.about,
  });

  factory AboutDetails.fromJson(Map<String, dynamic> json) => AboutDetails(
    about: json["about"],
  );

  Map<String, dynamic> toJson() => {
    "about": about,
  };
}

class DetailsModel {
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
  String business_name;
  String website;

  DetailsModel({
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
    required this.business_name,
    required this.website,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) => DetailsModel(
    id: json["id"],
    firstname: json["firstname"]??"",
    lastname: json["lastname"]??"",
    username: json["username"]??"",
    email: json["email"]??"",
    mobile: json["mobile"]??"",
    address: json["address"]??"",
    avatar: json["avatar"]??"",
    experience: json["experience"]??"",
    repeatClient: json["repeat_client"]??"",
    responseRate: json["response_rate"]??"",
    rating: json["rating"]??"",
    review: json["review"]??"",
    hourlyRate: json["hourly_rate"]??"",
    firebaseId: json["firebase_id"]??"",
    business_name: json["business_name"]??"",
    website: json["website"]??"",
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
    "business_name": business_name,
    "website": website,
  };
}

class ReviewList {
  int id;
  String customerName;
  String image;
  String rating;
  String title;
  String review;
  String timeAgo;

  ReviewList({
    required this.id,
    required this.customerName,
    required this.image,
    required this.rating,
    required this.title,
    required this.review,
    required this.timeAgo,
  });

  factory ReviewList.fromJson(Map<String, dynamic> json) => ReviewList(
    id: json["id"],
    customerName: json["customer_name"],
    image: json["image"],
    rating: json["rating"],
    title: json["title"],
    review: json["review"],
    timeAgo: json["time_ago"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_name": customerName,
    "image": image,
    "rating": rating,
    "title": title,
    "review": review,
    "time_ago": timeAgo,
  };
}


class PhotoListModel {
  int id;
  String photo;

  PhotoListModel({
    required this.id,
    required this.photo,
  });

  factory PhotoListModel.fromJson(Map<String, dynamic> json) => PhotoListModel(
    id: json["id"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "photo": photo,
  };
}


// class ServiceListDetailsModel {
//   HomeCleaning roomCleaner;
//   HomeCleaning homeCleaning;
//
//   ServiceListDetailsModel({
//     required this.roomCleaner,
//     required this.homeCleaning,
//   });
//
//   factory ServiceListDetailsModel.fromJson(Map<String, dynamic> json) => ServiceListDetailsModel(
//     roomCleaner: HomeCleaning.fromJson(json["Room Cleaner"]),
//     homeCleaning: HomeCleaning.fromJson(json["Home Cleaning"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Room Cleaner": roomCleaner.toJson(),
//     "Home Cleaning": homeCleaning.toJson(),
//   };
// }

// class ServiceListDetailsModel {
//   List<Standard> standard;
//   List<Deep> deep;
//
//   ServiceListDetailsModel({
//     required this.standard,
//     required this.deep,
//   });
//
//   factory ServiceListDetailsModel.fromJson(Map<String, dynamic> json) => ServiceListDetailsModel(
//     standard: List<Standard>.from(json["Standard"].map((x) => Deep.fromJson(x))),
//     deep: List<Deep>.from(json["Deep"].map((x) => Deep.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Standard": List<dynamic>.from(standard.map((x) => x.toJson())),
//     "Deep": List<dynamic>.from(deep.map((x) => x.toJson())),
//   };
// }

class ItemModel {
  String name;
  List<Standard> standard;
  List<Deep> deep;

  ItemModel.fromJson(String serviceName, Map<String, dynamic> json)
      : name = serviceName,
        standard = List<Standard>.from(json["Standard"].map((x) => Standard.fromJson(x))),
        deep = List<Deep>.from(json["Deep"].map((x) => Deep.fromJson(x)));

  Map<String, dynamic> toJson() => {
    "name": name,
    "standard": standard,
    "deep": deep,
  };
}

class Deep {
  int id;
  String title;
  String price;

  Deep({
    required this.id,
    required this.title,
    required this.price,
  });

  factory Deep.fromJson(Map<String, dynamic> json) => Deep(
    id: json["id"],
    title: json["title"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
  };
}
class Standard {
  int id;
  String title;
  String price;

  Standard({
    required this.id,
    required this.title,
    required this.price,
  });

  factory Standard.fromJson(Map<String, dynamic> json) => Standard(
    id: json["id"],
    title: json["title"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
  };
}


/// new models

// service detail model (stander & deep)
class ServiceDetailsModel {
  int id;
  String title;
  String icon;
  int isActive;
  List<String> priceLabelId;
  List<String> priceLabelText;
  List<String> priceLabelStandardPrice;
  List<String> priceLabelDeepPrice;

  ServiceDetailsModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.isActive,
    required this.priceLabelId,
    required this.priceLabelText,
    required this.priceLabelStandardPrice,
    required this.priceLabelDeepPrice,
  });

  factory ServiceDetailsModel.fromJson(Map<String, dynamic> json) => ServiceDetailsModel(
    id: json["id"],
    title: json["title"],
    icon: json["icon"],
    isActive: json["is_active"],
    priceLabelId: List<String>.from(json["price_label_id"].map((x) => x)),
    priceLabelText: List<String>.from(json["price_label_text"].map((x) => x)),
    priceLabelStandardPrice: List<String>.from(json["price_label_standard_price"].map((x) => x)),
    priceLabelDeepPrice: List<String>.from(json["price_label_deep_price"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "icon": icon,
    "is_active": isActive,
    "price_label_id": List<dynamic>.from(priceLabelId.map((x) => x)),
    "price_label_text": List<dynamic>.from(priceLabelText.map((x) => x)),
    "price_label_standard_price": List<dynamic>.from(priceLabelStandardPrice.map((x) => x)),
    "price_label_deep_price": List<dynamic>.from(priceLabelDeepPrice.map((x) => x)),
  };
}

// PerHourPriceServiceModel ( Hourly services )
class PerHourPriceServiceModel {
  List<BiWeeklyPrice> weekly;
  List<BiWeeklyPrice> biWeekly;
  List<BiWeeklyPrice> monthly;

  PerHourPriceServiceModel({
    required this.weekly,
    required this.biWeekly,
    required this.monthly,
  });

  factory PerHourPriceServiceModel.fromJson(Map<String, dynamic> json) => PerHourPriceServiceModel(
    weekly: List<BiWeeklyPrice>.from(json["weekly"].map((x) => BiWeeklyPrice.fromJson(x))),
    biWeekly: List<BiWeeklyPrice>.from(json["bi-weekly"].map((x) => BiWeeklyPrice.fromJson(x))),
    monthly: List<BiWeeklyPrice>.from(json["monthly"].map((x) => BiWeeklyPrice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "weekly": List<dynamic>.from(weekly.map((x) => x.toJson())),
    "bi-weekly": List<dynamic>.from(biWeekly.map((x) => x.toJson())),
    "monthly": List<dynamic>.from(monthly.map((x) => x.toJson())),
  };
}
class BiWeeklyPrice {
  String servicePrice;

  BiWeeklyPrice({
    required this.servicePrice,
  });

  factory BiWeeklyPrice.fromJson(Map<String, dynamic> json) => BiWeeklyPrice(
    servicePrice: json["service_price"],
  );

  Map<String, dynamic> toJson() => {
    "service_price": servicePrice,
  };
}
//  CoHost_Sq_ftServiceModel ( Sq ft )
class CoHostSqftServiceModel {
  List<BiWeekly> weekly;
  List<BiWeekly> biWeekly;
  List<BiWeekly> monthly;

  CoHostSqftServiceModel({
    required this.weekly,
    required this.biWeekly,
    required this.monthly,
  });

  factory CoHostSqftServiceModel.fromJson(Map<String, dynamic> json) => CoHostSqftServiceModel(
    weekly: List<BiWeekly>.from(json["weekly"].map((x) => BiWeekly.fromJson(x))),
    biWeekly: List<BiWeekly>.from(json["bi_weekly"].map((x) => BiWeekly.fromJson(x))),
    monthly: List<BiWeekly>.from(json["monthly"].map((x) => BiWeekly.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "weekly": List<dynamic>.from(weekly.map((x) => x.toJson())),
    "bi_weekly": List<dynamic>.from(biWeekly.map((x) => x.toJson())),
    "monthly": List<dynamic>.from(monthly.map((x) => x.toJson())),
  };
}
class BiWeekly {
  String squareFeet;
  String servicePrice;

  BiWeekly({
    required this.squareFeet,
    required this.servicePrice,
  });

  factory BiWeekly.fromJson(Map<String, dynamic> json) => BiWeekly(
    squareFeet: json["square_feet"],
    servicePrice: json["service_price"],
  );

  Map<String, dynamic> toJson() => {
    "square_feet": squareFeet,
    "service_price": servicePrice,
  };
}

class PriceLabel {
  final String id;
  final String text;
  final String standardPrice;
  final String deepPrice;

  PriceLabel({
    required this.id,
    required this.text,
    required this.standardPrice,
    required this.deepPrice,
  });
}





// testingg

// BlogDetailsModel blogDetailsModelFromJson(String str) => BlogDetailsModel.fromJson(json.decode(str));
//
// String blogDetailsModelToJson(BlogDetailsModel data) => json.encode(data.toJson());
//
// class BlogDetailsModel {
//   List<Service> service;
//
//   BlogDetailsModel({
//     required this.service,
//   });
//
//   factory BlogDetailsModel.fromJson(Map<String, dynamic> json) => BlogDetailsModel(
//     service: List<Service>.from(json["service"].map((x) => Service.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "service": List<dynamic>.from(service.map((x) => x.toJson())),
//   };
// }

class ServiceTestModel {
  // AirbnbVacationRental homeCleaning;
  String title;
  int serviceId;
  // AirbnbVacationRental airbnbVacationRental;
  // AirbnbVacationRental officeSpaceShops;
  // AirbnbVacationRental moveInMoveOut;
  // AirbnbVacationRental miscHomeOrgCookingLaundry;

  ServiceTestModel({
    // required this.homeCleaning,
    required this.title,
    required this.serviceId,
    // required this.airbnbVacationRental,
    // required this.officeSpaceShops,
    // required this.moveInMoveOut,
    // required this.miscHomeOrgCookingLaundry,
  });

  factory ServiceTestModel.fromJson(Map<String, dynamic> json) => ServiceTestModel(
    // homeCleaning: AirbnbVacationRental.fromJson(json["Home Cleaning"]),
    title: json["title"],
    serviceId: json["service_id"],
    // airbnbVacationRental: AirbnbVacationRental.fromJson(json["Airbnb/Vacation Rental"]),
    // officeSpaceShops: AirbnbVacationRental.fromJson(json["Office Space/Shops"]),
    // moveInMoveOut: AirbnbVacationRental.fromJson(json["Move In Move Out"]),
    // miscHomeOrgCookingLaundry: AirbnbVacationRental.fromJson(json["Misc. (Home Org/Cooking/Laundry)"]),
  );

  Map<String, dynamic> toJson() => {
    // "Home Cleaning": homeCleaning.toJson(),
    "title": title,
    "service_id": serviceId,
    // "Airbnb/Vacation Rental": airbnbVacationRental.toJson(),
    // "Office Space/Shops": officeSpaceShops.toJson(),
    // "Move In Move Out": moveInMoveOut.toJson(),
    // "Misc. (Home Org/Cooking/Laundry)": miscHomeOrgCookingLaundry.toJson(),
  };
}

// class AirbnbVacationRental {
//   List<dynamic> standard;
//   List<dynamic> deep;
//
//   AirbnbVacationRental({
//     required this.standard,
//     required this.deep,
//   });
//
//   factory AirbnbVacationRental.fromJson(Map<String, dynamic> json) => AirbnbVacationRental(
//     standard: List<dynamic>.from(json["Standard"].map((x) => x)),
//     deep: List<dynamic>.from(json["Deep"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Standard": List<dynamic>.from(standard.map((x) => x)),
//     "Deep": List<dynamic>.from(deep.map((x) => x)),
//   };
// }



