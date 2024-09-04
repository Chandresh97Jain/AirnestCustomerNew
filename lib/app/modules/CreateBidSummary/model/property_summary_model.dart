// To parse this JSON data, do
//
//     final propertySummaryModel = propertySummaryModelFromJson(jsonString);



class PropertySummaryModel {
  int id;
  String name;
  String address;
  String propertySize;
  int dontKnowPropertySize;
  String propertyDate;
  String propertyTime;
  String description;
  String serviceType;

  PropertySummaryModel({
    required this.id,
    required this.name,
    required this.address,
    required this.propertySize,
    required this.dontKnowPropertySize,
    required this.propertyDate,
    required this.propertyTime,
    required this.description,
    required this.serviceType,
  });

  factory PropertySummaryModel.fromJson(Map<String, dynamic> json) => PropertySummaryModel(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    propertySize: json["property_size"],
    dontKnowPropertySize: json["dont_know_property_size"],
    propertyDate: json["property_date"],
    propertyTime: json["property_time"],
    description: json["description"],
    serviceType: json["service_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "property_size": propertySize,
    "dont_know_property_size": dontKnowPropertySize,
    "property_date": propertyDate,
    "property_time": propertyTime,
    "description": description,
    "service_type": serviceType,
  };
}
