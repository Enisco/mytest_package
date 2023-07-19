import 'dart:convert';

KorapayOtpAuthModel korapayOtpAuthModelFromJson(String str) =>
    KorapayOtpAuthModel.fromJson(json.decode(str));

String korapayOtpAuthModelToJson(KorapayOtpAuthModel data) =>
    json.encode(data.toJson());

class KorapayOtpAuthModel {
  final String? transactionReference;
  final OtpAuthorization? authorization;

  KorapayOtpAuthModel({
    this.transactionReference,
    this.authorization,
  });

  KorapayOtpAuthModel copyWith({
    String? transactionReference,
    OtpAuthorization? authorization,
  }) =>
      KorapayOtpAuthModel(
        transactionReference: transactionReference ?? this.transactionReference,
        authorization: authorization ?? this.authorization,
      );

  factory KorapayOtpAuthModel.fromJson(Map<String, dynamic> json) =>
      KorapayOtpAuthModel(
        transactionReference: json["transaction_reference"],
        authorization: json["authorization"] == null
            ? null
            : OtpAuthorization.fromJson(json["authorization"]),
      );

  Map<String, dynamic> toJson() => {
        "transaction_reference": transactionReference,
        "authorization": authorization?.toJson(),
      };
}

class OtpAuthorization {
  final String? otp;

  OtpAuthorization({
    this.otp,
  });

  OtpAuthorization copyWith({
    String? otp,
  }) =>
      OtpAuthorization(
        otp: otp ?? this.otp,
      );

  factory OtpAuthorization.fromJson(Map<String, dynamic> json) =>
      OtpAuthorization(
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
      };
}
