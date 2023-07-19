import 'dart:convert';

import 'package:mytest_package/src/models/card_model.dart';
import 'package:mytest_package/src/models/customer_model.dart';
import 'package:mytest_package/src/models/metadata_model.dart';

KorapayChargeData korapayChargeDataFromJson(String str) =>
    KorapayChargeData.fromJson(json.decode(str));

String korapayChargeDataToJson(KorapayChargeData data) =>
    json.encode(data.toJson());

class KorapayChargeData {
  String? reference;
  KorapayCard? card;
  int? amount;
  String? currency;
  String? redirectUrl;
  KorapayCustomer? customer;
  KorapayMetadata? metadata;

  KorapayChargeData({
    required this.reference,
    required this.card,
    required this.amount,
    this.currency,
    this.redirectUrl,
    required this.customer,
    this.metadata,
  });

  KorapayChargeData copyWith({
    String? reference,
    KorapayCard? card,
    int? amount,
    String? currency,
    String? redirectUrl,
    KorapayCustomer? customer,
    KorapayMetadata? metadata,
  }) =>
      KorapayChargeData(
        reference: reference ?? this.reference,
        card: card ?? this.card,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
        redirectUrl: redirectUrl ?? this.redirectUrl,
        customer: customer ?? this.customer,
        metadata: metadata ?? this.metadata,
      );

  factory KorapayChargeData.fromJson(Map<String, dynamic> json) =>
      KorapayChargeData(
        reference: json["reference"],
        card: json["card"] == null ? null : KorapayCard.fromJson(json["card"]),
        amount: json["amount"],
        currency: json["currency"],
        redirectUrl: json["redirect_url"],
        customer: json["customer"] == null
            ? null
            : KorapayCustomer.fromJson(json["customer"]),
        metadata: json["metadata"] == null
            ? null
            : KorapayMetadata.fromJson(json["metadata"]),
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
