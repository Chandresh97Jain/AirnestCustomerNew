class NotificationListModule {
  String? id;
  String? title;
  String? message;
  String? sender_id;
  String? notification_type;
  String? notification_id;
  String? is_read;
  String? date_time;
  String? sender_img;

  NotificationListModule({
    this.id,
    this.title,
    this.message,
    this.sender_id,
    this.notification_type,
    this.notification_id,
    this.is_read,
    this.date_time,
    this.sender_img,
  });

  factory NotificationListModule.fromJson(Map<String, dynamic> json) =>
      NotificationListModule(
        id: json["id"].toString() ?? "",
        title: json["title"].toString() ?? "",
        message: json["message"].toString() ?? "",
        sender_id: json["sender_id"].toString() ?? "",
        notification_type: json["notification_type"].toString() ?? "",
        notification_id: json["notification_id"].toString() ?? "",
        is_read: json["is_read"].toString() ?? "",
        date_time: json["date_time"].toString() ?? "",
        sender_img: json["sender_img"].toString() ?? "",

      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "message": message,
    "sender_id": sender_id,
    "notification_type": notification_type,
    "notification_id": notification_id,
    "is_read": is_read,
    "date_time": date_time,
    "sender_img": sender_img,


  };
}
