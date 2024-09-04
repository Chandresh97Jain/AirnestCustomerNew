// To parse this JSON data, do
//
//     final sqrFeelModel = sqrFeelModelFromJson(jsonString);



class SqrFeelModel {
  int id;
  String squareFeet;

  SqrFeelModel({
    required this.id,
    required this.squareFeet,
  });

  factory SqrFeelModel.fromJson(Map<String, dynamic> json) => SqrFeelModel(
    id: json["id"],
    squareFeet: json["square_feet"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "square_feet": squareFeet,
  };
}
