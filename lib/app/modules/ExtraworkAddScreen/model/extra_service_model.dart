// To parse this JSON data, do
//
//     final extraServicesModel = extraServicesModelFromJson(jsonString);




class ExtraServicesModel {
  int id;
  String title;
  String price;

  ExtraServicesModel({
    required this.id,
    required this.title,
    required this.price,
  });

  factory ExtraServicesModel.fromJson(Map<String, dynamic> json) => ExtraServicesModel(
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
