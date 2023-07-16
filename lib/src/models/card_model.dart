import 'dart:convert';

KorapayCard korapayCardFromJson(String str) =>
    KorapayCard.fromJson(json.decode(str));

String korapayCardToJson(KorapayCard data) => json.encode(data.toJson());

class KorapayCard {
  String? name;
  String? number;
  String? cvv;
  String? expiryMonth;
  String? expiryYear;
  String? pin;

  KorapayCard({
    this.name,
    required this.number,
    required this.cvv,
    required this.expiryMonth,
    required this.expiryYear,
    this.pin,
  });

  KorapayCard copyWith({
    String? name,
    String? number,
    String? cvv,
    String? expiryMonth,
    String? expiryYear,
    String? pin,
  }) =>
      KorapayCard(
        name: name ?? this.name,
        number: number ?? this.number,
        cvv: cvv ?? this.cvv,
        expiryMonth: expiryMonth ?? this.expiryMonth,
        expiryYear: expiryYear ?? this.expiryYear,
        pin: pin ?? this.pin,
      );

  factory KorapayCard.fromJson(Map<String, dynamic> json) => KorapayCard(
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
