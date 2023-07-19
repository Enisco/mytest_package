// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mytest_package/mytest_package.dart';
import 'package:mytest_package/src/korapay/encrypt_charge_data.dart';
import 'package:mytest_package/src/models/card_model.dart';
import 'package:mytest_package/src/models/charge_data_model.dart';
import 'package:mytest_package/src/models/charge_data_resp_model.dart';
import 'package:mytest_package/src/models/customer_model.dart';
import 'package:mytest_package/src/models/metadata_model.dart';
import 'package:mytest_package/src/models/otp_auth_model.dart';
import 'package:mytest_package/src/models/pin_auth_model.dart';

enum Authorization {
  pin,
  otp,
}

enum Success {
  initializaTionDone,
  chargingCard,
}

enum Errors {
  initializationError,
  invalidCardPin,
  incorrectChargeData,
  verificationFailure,
}

// String kEencryptionKey =
//     "P9EqWkDGApD2FX3jiEUqdXq32zMj6Urp";

String? _kEencryptionKey, _cardPin, _transactionRef;
KorapayChargeData? _kChargeData;

class Korapay {
  final ApiServices _apiServices = ApiServices();

  initialize({
    required Authorization authorization,
    required String encryptionKey,
    required String secretKey,
    required String transactionRef,
    String cardName = "User card",
    required String cardNumber,
    required String cvv,
    required String expiryMonth,
    required String expiryYear,
    String currency = "NGN",
    required String redirectUrl,
    String? pin = "0000",
    required int amount,
    String name = "None",
    required String email,
    required String metadata,
  }) {
    if (encryptionKey == '' || encryptionKey.length < 32) {
      Errors.initializationError;
      debugPrint("Invalid encryption key");
      return Errors.initializationError;
    } else if (authorization == Authorization.pin && pin == null) {
      debugPrint("No value specified for \"pin\"");
      return Errors.initializationError;
    } else {
      _kEencryptionKey = encryptionKey;
      token = secretKey;
      KorapayChargeData chargeData = KorapayChargeData(
        reference: transactionRef,
        card: KorapayCard(
          name: cardName,
          number: cardNumber,
          cvv: cvv,
          expiryMonth: expiryMonth,
          expiryYear: expiryYear,
          pin: pin,
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
      debugPrint(chargeData.toJson().toString());
      _kChargeData = chargeData;
      _cardPin = pin;
      debugPrint("Korapay Initialization Successful");
      // return Success.initializaTionDone;
      charge();
    }
  }

  Future charge() async {
    String encryptedChargeData = _generateChargeData();

    /// Charge Card
    try {
      var chargeCardResponse =
          await _apiServices.chargeCard(encryptedChargeData);
      if (chargeCardResponse['status'] == true) {
        var dataBody = chargeCardResponse['data'];
        ChargeCardResponseModel chargeCardResponseData =
            chargeCardResponseModelFromJson(
          jsonEncode(
            dataBody,
          ),
        );
        //
        _transactionRef = chargeCardResponseData.paymentReference;
        if (chargeCardResponseData.authModel?.toLowerCase() ==
            Authorization.pin.name.toLowerCase()) {
          // TODO: Call authorize with pin
          authorizeWithPin();
          return Success.chargingCard;
        } else if (chargeCardResponseData.authModel?.toLowerCase() ==
            Authorization.otp.name.toLowerCase()) {
          // TODO: Request user to enter OTP received
          authorizeWithOtp("123456");
          return Success.chargingCard;
        }
      } else {
        return Errors.incorrectChargeData;
      }
    } catch (e) {
      debugPrint("Error charging data");
    }
  }

  authorizeWithPin() async {
    KorapayPinAuthModel pinAuthData = KorapayPinAuthModel(
      transactionReference: _transactionRef,
      authorization: PinAuthorization(
        pin: _cardPin,
      ),
    );
    final resp = await _apiServices.authorizeTransaction(
      korapayPinAuthModelToJson(pinAuthData),
    );
  }

  authorizeWithOtp(String otpEntered) async {
    KorapayOtpAuthModel otpAuthData = KorapayOtpAuthModel(
      transactionReference: _transactionRef,
      authorization: OtpAuthorization(
        otp: otpEntered,
      ),
    );
    final resp = await _apiServices.authorizeTransaction(
      korapayOtpAuthModelToJson(otpAuthData),
    );
  }

  String _generateChargeData() {
    String encryptChargeDataResponse = encryptChargeData(
      _kEencryptionKey!,
      korapayChargeDataToJson(_kChargeData!),
    );

    return encryptChargeDataResponse;
  }
}
