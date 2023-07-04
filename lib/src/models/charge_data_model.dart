// To parse this JSON data, do
//
//     final korapayChargeDataModel = korapayChargeDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:mytest_package/mytest_package.dart';

KorapayChargeDataModel korapayChargeDataModelFromJson(String str) =>
    KorapayChargeDataModel.fromJson(json.decode(str));

String korapayChargeDataModelToJson(KorapayChargeDataModel data) =>
    json.encode(data.toJson());

class KorapayChargeDataModel {
  String? reference;
  KorapayCardModel? card;
  int? amount;
  String? currency;
  String? redirectUrl;
  KorapayCustomerModel? customer;
  KorapayMetadataModel? metadata;

  KorapayChargeDataModel({
    this.reference,
    this.card,
    this.amount,
    this.currency,
    this.redirectUrl,
    this.customer,
    this.metadata,
  });

  KorapayChargeDataModel copyWith({
    String? reference,
    KorapayCardModel? card,
    int? amount,
    String? currency,
    String? redirectUrl,
    KorapayCustomerModel? customer,
    KorapayMetadataModel? metadata,
  }) =>
      KorapayChargeDataModel(
        reference: reference ?? this.reference,
        card: card ?? this.card,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
        redirectUrl: redirectUrl ?? this.redirectUrl,
        customer: customer ?? this.customer,
        metadata: metadata ?? this.metadata,
      );

  factory KorapayChargeDataModel.fromJson(Map<String, dynamic> json) =>
      KorapayChargeDataModel(
        reference: json["reference"],
        card: json["card"] == null
            ? null
            : KorapayCardModel.fromJson(json["card"]),
        amount: json["amount"],
        currency: json["currency"],
        redirectUrl: json["redirect_url"],
        customer: json["customer"] == null
            ? null
            : KorapayCustomerModel.fromJson(json["customer"]),
        metadata: json["metadata"] == null
            ? null
            : KorapayMetadataModel.fromJson(json["metadata"]),
      );

  Map<String, dynamic> toJson() => {
        "reference": reference,
        "card": card?.toJson(),
        "amount": amount,
        "currency": currency,
        "redirect_url": redirectUrl,
        "customer": customer?.toJson(),
        "metadata": metadata?.toJson(),
      };
}
