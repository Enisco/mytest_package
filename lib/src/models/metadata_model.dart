// To parse this JSON data, do
//
//     final korapayMetadataModel = korapayMetadataModelFromJson(jsonString);

import 'dart:convert';

KorapayMetadataModel korapayMetadataModelFromJson(String str) => KorapayMetadataModel.fromJson(json.decode(str));

String korapayMetadataModelToJson(KorapayMetadataModel data) => json.encode(data.toJson());

class KorapayMetadataModel {
    String? username;
    int? datetime;

    KorapayMetadataModel({
        this.username,
        this.datetime,
    });

    KorapayMetadataModel copyWith({
        String? username,
        int? datetime,
    }) => 
        KorapayMetadataModel(
            username: username ?? this.username,
            datetime: datetime ?? this.datetime,
        );

    factory KorapayMetadataModel.fromJson(Map<String, dynamic> json) => KorapayMetadataModel(
        username: json["username"],
        datetime: json["datetime"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "datetime": datetime,
    };
}
