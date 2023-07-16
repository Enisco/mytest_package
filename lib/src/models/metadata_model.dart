import 'dart:convert';

KorapayMetadata korapayMetadataFromJson(String str) =>
    KorapayMetadata.fromJson(json.decode(str));

String korapayMetadataToJson(KorapayMetadata data) =>
    json.encode(data.toJson());

class KorapayMetadata {
  String? metadata;
  String? datetime;

  KorapayMetadata({
    this.metadata,
    this.datetime,
  });

  KorapayMetadata copyWith({
    String? metadata,
    String? datetime,
  }) =>
      KorapayMetadata(
        metadata: metadata ?? this.metadata,
        datetime: datetime ?? this.datetime,
      );

  factory KorapayMetadata.fromJson(Map<String, dynamic> json) =>
      KorapayMetadata(
        metadata: json["metadata"],
        datetime: json["datetime"],
      );

  Map<String, dynamic> toJson() => {
        "metadata": metadata,
        "datetime": datetime,
      };
}
