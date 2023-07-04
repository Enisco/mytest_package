import 'dart:convert';

KorapayCustomerModel korapayCustomerModelFromJson(String str) => KorapayCustomerModel.fromJson(json.decode(str));

String korapayCustomerModelToJson(KorapayCustomerModel data) => json.encode(data.toJson());

class KorapayCustomerModel {
    String? name;
    String? email;

    KorapayCustomerModel({
        this.name,
        this.email,
    });

    KorapayCustomerModel copyWith({
        String? name,
        String? email,
    }) => 
        KorapayCustomerModel(
            name: name ?? this.name,
            email: email ?? this.email,
        );

    factory KorapayCustomerModel.fromJson(Map<String, dynamic> json) => KorapayCustomerModel(
        name: json["name"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
    };
}
