import 'dart:convert';

KorapayCardModel korapayCardModelFromJson(String str) =>
    KorapayCardModel.fromJson(json.decode(str));

String korapayCardModelToJson(KorapayCardModel data) =>
    json.encode(data.toJson());

class KorapayCardModel {
  String? name;
  String? number;
  String? cvv;
  String? expiryMonth;
  String? expiryYear;
  String? pin;

  KorapayCardModel({
    this.name,
    this.number,
    this.cvv,
    this.expiryMonth,
    this.expiryYear,
    this.pin,
  });

  KorapayCardModel copyWith({
    String? name,
    String? number,
    String? cvv,
    String? expiryMonth,
    String? expiryYear,
    String? pin,
  }) =>
      KorapayCardModel(
        name: name ?? this.name,
        number: number ?? this.number,
        cvv: cvv ?? this.cvv,
        expiryMonth: expiryMonth ?? this.expiryMonth,
        expiryYear: expiryYear ?? this.expiryYear,
        pin: pin ?? this.pin,
      );

  factory KorapayCardModel.fromJson(Map<String, dynamic> json) =>
      KorapayCardModel(
        name: json["name"],
        number: json["number"],
        cvv: json["cvv"],
        expiryMonth: json["expiry_month"],
        expiryYear: json["expiry_year"],
        pin: json["pin"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "number": number,
        "cvv": cvv,
        "expiry_month": expiryMonth,
        "expiry_year": expiryYear,
        "pin": pin,
      };
}
