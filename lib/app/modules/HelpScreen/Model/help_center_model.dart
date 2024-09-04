class HelpCenterModel {
  String? title;
  String? content;

  HelpCenterModel({
    this.title,
    this.content,
  });

  factory HelpCenterModel.fromJson(Map<String, dynamic> json) =>
      HelpCenterModel(
        title: json["title"].toString() ?? "",
        content: json["content"].toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
  };
}
