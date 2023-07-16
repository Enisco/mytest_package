import 'package:flutter/material.dart';
import 'package:mytest_package/mytest_package.dart';
import 'package:mytest_package/src/korapay/encrypt_charge_data.dart';
import 'package:mytest_package/src/models/charge_data_model.dart';

// String kEencryptionKey =
//     "P9EqWkDGApD2FX3jiEUqdXq32zMj6Urp";

enum Authorization { pin, otp }

String? kEencryptionKey;
KorapayChargeData? chargeData;

class Korapay {
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
    String? pin,
    required int amount,
    String name = "None",
    String email = "None",
    required String metadata,
  }) {
    if (encryptionKey == '' || encryptionKey.length < 32) {
      throw ("Invalid encryption key");
    } else {
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

      final encryptedChargeData = generateChargeData(chargeData);
      debugPrint("Encrypted Charge Data: $encryptedChargeData");
    }
  }

  String generateChargeData(KorapayChargeData chargeData) {
    String encryptChargeDataResponse = encryptChargeData(
      kEencryptionKey!,
      chargeData.toJson().toString(),
    );

    return encryptChargeDataResponse;
  }
}
