import 'dart:convert';

EncChargeDataModel encChargeDataModelFromJson(String str) =>
    EncChargeDataModel.fromJson(json.decode(str));

String encChargeDataModelToJson(EncChargeDataModel data) =>
    json.encode(data.toJson());

class EncChargeDataModel {
  final String? chargeData;

  EncChargeDataModel({
    this.chargeData,
  });

  factory EncChargeDataModel.fromJson(Map<String, dynamic> json) =>
      EncChargeDataModel(
        chargeData: json["charge_data"],
      );

  Map<String, dynamic> toJson() => {
        "charge_data": chargeData,
      };
}
