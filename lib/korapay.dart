import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mytest_package/mytest_package.dart';
import 'package:mytest_package/src/korapay/encrypt_charge_data.dart';
import 'package:mytest_package/src/models/card_model.dart';
import 'package:mytest_package/src/models/charge_data_model.dart';
import 'package:mytest_package/src/models/charge_data_resp_model.dart';
import 'package:mytest_package/src/models/customer_model.dart';
import 'package:mytest_package/src/models/metadata_model.dart';

// String kEencryptionKey =
//     "P9EqWkDGApD2FX3jiEUqdXq32zMj6Urp";

String? _kEencryptionKey, cardPin;
KorapayChargeData? _kChargeData;

class Korapay {
  final ApiServices _apiServices = ApiServices();

  initialize({
    required Authorization authorization,
    required String encryptionKey,
    required String transactionRef,
    String cardName = "User card",
    required String cardNumber,
    required String cvv,
    required String expiryMonth,
    required String expiryYear,
    String currency = "NGN",
    String? redirectUrl,
    int? pin,
    required int amount,
    String name = "None",
    String email = "None",
    required String metadata,
  }) {
    if (encryptionKey == '' || encryptionKey.length < 32) {
      throw ("Invalid encryption key");
    } else if (authorization == Authorization.pin && pin == null) {
      throw ("No value specified for \"pin\"");
    } else {
      _kEencryptionKey = encryptionKey;
      KorapayChargeData chargeData = KorapayChargeData(
        reference: transactionRef,
        card: KorapayCard(
          name: cardName,
          number: cardNumber,
          cvv: cvv,
          expiryMonth: expiryMonth,
          expiryYear: expiryYear,
        ),
        amount: amount,
        currency: currency,
        redirectUrl: redirectUrl,
        customer: KorapayCustomer(
          name: name,
          email: email,
        ),
        metadata: KorapayMetadata(
          metadata: metadata,
          datetime: DateTime.now().toString(),
        ),
      );
      _kChargeData = chargeData;
      debugPrint("Korapay Initialization Successful");
    }
  }

  Future charge() async {
    String encryptedChargeData = _generateChargeData();

    /// Charge Card
    var chargeCardResponse = await _apiServices.chargeCard(encryptedChargeData);
    if (chargeCardResponse['status'] == true) {
      var dataBody = chargeCardResponse['data'];
      ChargeCardResponseModel chargeCardResponseData =
          chargeCardResponseModelFromJson(
        jsonEncode(
          dataBody,
        ),
      );
    } else {}
    //
    return encryptedChargeData;
  }

  String _generateChargeData() {
    String encryptChargeDataResponse = encryptChargeData(
      _kEencryptionKey!,
      _kChargeData!.toJson().toString(),
    );

    return encryptChargeDataResponse;
  }
}

List errors = ['E'];
