
class BlogDetailsModel {
  int id;
  String title;
  String image;
  String description;

  BlogDetailsModel({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
  });

  factory BlogDetailsModel.fromJson(Map<String, dynamic> json) => BlogDetailsModel(
    id: json["id"],
    title: json["title"]??"",
    image: json["image"]??"",
    description: json["description"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "description": description,
  };
}
