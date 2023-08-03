// ignore_for_file: prefer_null_aware_operators, constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mytest_package/mytest_package.dart';
import 'package:mytest_package/src/korapay/encrypt_charge_data.dart';
import 'package:mytest_package/src/models/card_model.dart';
import 'package:mytest_package/src/models/charge_data_model.dart';
import 'package:mytest_package/src/models/charge_data_resp_model.dart';
import 'package:mytest_package/src/models/customer_model.dart';
import 'package:mytest_package/src/models/enc_charge_model.dart';
import 'package:mytest_package/src/models/metadata_model.dart';
import 'package:mytest_package/src/models/otp_auth_model.dart';
import 'package:mytest_package/src/models/pin_auth_model.dart';


enum _Authorization {
  pin, 
  otp,
  no_auth,
}

enum Success {
  initializaTionDone,
  chargingCard,
}

enum Errors {
  initializationError,
  invalidCardPin,
  authenticationTypeNotSupported,
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
    String? pin,
    required int amount,
    String name = "None",
    required String email,
    required String metadata,
  }) async {
    if (encryptionKey == '' || encryptionKey.length < 32) {
      Errors.initializationError;
      debugPrint("Invalid encryption key");
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
          pin: pin ?? "0000",
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
      var resp = await _charge();
      return resp;
    }
  }

  Future _charge() async {
    String encryptedChargeString = _generateChargeData();
    EncChargeDataModel encryptedChargeData = EncChargeDataModel(
      chargeData: encryptedChargeString,
    );

    /// Charge Card
    try {
      var chargeCardResponse = await _apiServices.chargeCard(
        encChargeDataModelToJson(encryptedChargeData),
      );
      if (chargeCardResponse['status'] == true) {
        var dataBody = chargeCardResponse['data'];
        ChargeCardResponseModel chargeCardResponseData =
            chargeCardResponseModelFromJson(
          jsonEncode(
            dataBody,
          ),
        );
        //
        _transactionRef = chargeCardResponseData.transactionReference;
        if (chargeCardResponseData.authModel?.toLowerCase() ==
            _Authorization.pin.name.toLowerCase()) {
          await _authorizeWithPin();
          return Success.chargingCard;
        } else if (chargeCardResponseData.authModel?.toLowerCase() ==
            _Authorization.otp.name.toLowerCase()) {
          // TODO: Request user to enter OTP received
          await _authorizeWithOtp("123456");
          return Success.chargingCard;
        } else if (chargeCardResponseData.authModel?.toLowerCase() ==
            _Authorization.no_auth.name.toLowerCase()) {
          debugPrint("Charged card with NO_AUTH");
          return Success.chargingCard;
        }
      } else {
        return Errors.incorrectChargeData;
      }
    } catch (e) {
      debugPrint("Error charging data");
    }
  }

  _authorizeWithPin() async {
    if (_cardPin == null) {
      return Errors.invalidCardPin;
    }
    KorapayPinAuthModel pinAuthData = KorapayPinAuthModel(
      transactionReference: _transactionRef,
      authorization: PinAuthorization(
        pin: _cardPin,
      ),
    );
    final resp = await _apiServices.authorizeTransaction(
      korapayPinAuthModelToJson(pinAuthData),
    );
    // if (resp)
  }

  _authorizeWithOtp(String otpEntered) async {
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
