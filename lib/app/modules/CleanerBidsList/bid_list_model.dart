// To parse this JSON data, do
//
//     final bidListModel = bidListModelFromJson(jsonString);



class BidListModel {
  int id;
  String address;
  String created;
  int totalBid;
  String serviceTitle;
  String status;
  List<Summary> summary;

  BidListModel({
    required this.id,
    required this.address,
    required this.created,
    required this.totalBid,
    required this.summary,
    required this.serviceTitle,
    required this.status,

  });

  factory BidListModel.fromJson(Map<String, dynamic> json) => BidListModel(
    id: json["id"],
    address: json["address"],
    created: json["created"],
    totalBid: json["total_bid"],
    serviceTitle: json["service_title"],
    status: json["status"],
    summary: List<Summary>.from(json["summary"].map((x) => Summary.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "created": created,
    "total_bid": totalBid,
    "service_title": serviceTitle,
    "status": status,
    "summary": List<dynamic>.from(summary.map((x) => x.toJson())),
  };
}

class Summary {
  int id;
  String title;
  String address;
  String propertySize;
  int dontKnowPropertySize;
  DateTime bookingData;
  String bookingTime;
  String description;
  String zipcode;
  dynamic describeYourNeed;
  int cleanerNeedsToWashAndDryLinenAndTowels;
  int iProvideCleaningSupplies;

  Summary({
    required this.id,
    required this.title,
    required this.address,
    required this.propertySize,
    required this.dontKnowPropertySize,
    required this.bookingData,
    required this.bookingTime,
    required this.description,
    required this.zipcode,
    required this.describeYourNeed,
    required this.cleanerNeedsToWashAndDryLinenAndTowels,
    required this.iProvideCleaningSupplies,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    id: json["id"],
    title: json["title"],
    address: json["address"],
    propertySize: json["property_size"],
    dontKnowPropertySize: json["dont_know_property_size"],
    bookingData: DateTime.parse(json["booking_data"]),
    bookingTime: json["booking_time"],
    description: json["description"],
    zipcode: json["zipcode"],
    describeYourNeed: json["describe_your_need"],
    cleanerNeedsToWashAndDryLinenAndTowels: json["cleaner_needs_to_wash_and_dry_linen_and_towels"]??0,
    iProvideCleaningSupplies: json["i_provide_cleaning_supplies"]??0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "address": address,
    "property_size": propertySize,
    "dont_know_property_size": dontKnowPropertySize,
    "booking_data": "${bookingData.year.toString().padLeft(4, '0')}-${bookingData.month.toString().padLeft(2, '0')}-${bookingData.day.toString().padLeft(2, '0')}",
    "booking_time": bookingTime,
    "description": description,
    "zipcode": zipcode,
    "describe_your_need": describeYourNeed,
    "cleaner_needs_to_wash_and_dry_linen_and_towels": cleanerNeedsToWashAndDryLinenAndTowels,
    "i_provide_cleaning_supplies": iProvideCleaningSupplies,
  };
}
