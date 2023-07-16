import 'dart:convert';

KorapayCustomer korapayCustomerFromJson(String str) =>
    KorapayCustomer.fromJson(json.decode(str));

String korapayCustomerToJson(KorapayCustomer data) =>
    json.encode(data.toJson());

class KorapayCustomer {
  String? name;
  String? email;

  KorapayCustomer({
    this.name,
    this.email,
  });

  KorapayCustomer copyWith({
    String? name,
    String? email,
  }) =>
      KorapayCustomer(
        name: name ?? this.name,
        email: email ?? this.email,
      );

  factory KorapayCustomer.fromJson(Map<String, dynamic> json) =>
      KorapayCustomer(
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
      };
}
