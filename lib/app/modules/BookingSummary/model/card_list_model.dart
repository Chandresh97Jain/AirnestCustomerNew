// To parse this JSON data, do
//
//     final cardListModel = cardListModelFromJson(jsonString);




class CardListModel {
  int id;
  String cardHolderName;
  String cardNumber;
  String expMonth;
  String expYear;
  int cvv;

  CardListModel({
    required this.id,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expMonth,
    required this.expYear,
    required this.cvv,
  });

  factory CardListModel.fromJson(Map<String, dynamic> json) => CardListModel(
    id: json["id"],
    cardHolderName: json["card_holder_name"]??'',
    cardNumber: json["card_number"],
    expMonth: json["exp_month"],
    expYear: json["exp_year"],
    cvv: json["cvv"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "card_holder_name": cardHolderName,
    "card_number": cardNumber,
    "exp_month": expMonth,
    "exp_year": expYear,
    "cvv": cvv,
  };
}
