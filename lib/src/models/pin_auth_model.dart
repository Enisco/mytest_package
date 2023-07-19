import 'dart:convert';

KorapayPinAuthModel korapayPinAuthModelFromJson(String str) =>
    KorapayPinAuthModel.fromJson(json.decode(str));

String korapayPinAuthModelToJson(KorapayPinAuthModel data) =>
    json.encode(data.toJson());

class KorapayPinAuthModel {
  final String? transactionReference;
  final PinAuthorization? authorization;

  KorapayPinAuthModel({
    this.transactionReference,
    this.authorization,
  });

  KorapayPinAuthModel copyWith({
    String? transactionReference,
    PinAuthorization? authorization,
  }) =>
      KorapayPinAuthModel(
        transactionReference: transactionReference ?? this.transactionReference,
        authorization: authorization ?? this.authorization,
      );

  factory KorapayPinAuthModel.fromJson(Map<String, dynamic> json) =>
      KorapayPinAuthModel(
        transactionReference: json["transaction_reference"],
        authorization: json["authorization"] == null
            ? null
            : PinAuthorization.fromJson(json["authorization"]),
      );

  Map<String, dynamic> toJson() => {
        "transaction_reference": transactionReference,
        "authorization": authorization?.toJson(),
      };
}

class PinAuthorization {
  final String? pin;

  PinAuthorization({
    this.pin,
  });

  PinAuthorization copyWith({
    String? pin,
  }) =>
      PinAuthorization(
        pin: pin ?? this.pin,
      );

  factory PinAuthorization.fromJson(Map<String, dynamic> json) =>
      PinAuthorization(
        pin: json["pin"],
      );

  Map<String, dynamic> toJson() => {
        "pin": pin,
      };
}
