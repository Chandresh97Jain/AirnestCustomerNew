// To parse this JSON data, do
//
//     final bookingRequestModel = bookingRequestModelFromJson(jsonString);



class BookingRequestModel {
  int id;
  String address;
  String bookingDate;
  String bookingTime;
  String cleanerName;
  String avatar;
  String price;
  String rating;
  String review;
  String status;
  String firebaseId;

  BookingRequestModel({
    required this.id,
    required this.address,
    required this.bookingDate,
    required this.bookingTime,
    required this.cleanerName,
    required this.avatar,
    required this.price,
    required this.rating,
    required this.review,
    required this.status,
    required this.firebaseId,
  });

  factory BookingRequestModel.fromJson(Map<String, dynamic> json) => BookingRequestModel(
    id: json["id"]??'',
    address: json["address"]??'',
    bookingDate: json["booking_date"]??'',
    bookingTime: json["booking_time"]??'',
    cleanerName: json["cleaner_name"]??'',
    avatar: json["avatar"]??'',
    price: json["price"]??'',
    rating: json["rating"]??00,
    review: json["review"]??'',
    status: json["status"]??'',
    firebaseId: json["firebase_id"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "booking_date": bookingDate,
    "booking_time": bookingTime,
    "cleaner_name": cleanerName,
    "avatar": avatar,
    "price": price,
    "rating": rating,
    "review": review,
    "status": status,
    "firebase_id": firebaseId,
  };
}
