import 'dart:convert';

ChargeCardResponseModel chargeCardResponseModelFromJson(String str) => ChargeCardResponseModel.fromJson(json.decode(str));

String chargeCardResponseModelToJson(ChargeCardResponseModel data) => json.encode(data.toJson());

class ChargeCardResponseModel {
    final int? amount;
    final int? amountCharged;
    final String? authModel;
    final String? currency;
    final double? fee;
    final double? vat;
    final String? responseMessage;
    final String? paymentReference;
    final String? status;
    final String? transactionReference;
    final Card? card;

    ChargeCardResponseModel({
        this.amount,
        this.amountCharged,
        this.authModel,
        this.currency,
        this.fee,
        this.vat,
        this.responseMessage,
        this.paymentReference,
        this.status,
        this.transactionReference,
        this.card,
    });

    ChargeCardResponseModel copyWith({
        int? amount,
        int? amountCharged,
        String? authModel,
        String? currency,
        double? fee,
        double? vat,
        String? responseMessage,
        String? paymentReference,
        String? status,
        String? transactionReference,
        Card? card,
    }) => 
        ChargeCardResponseModel(
            amount: amount ?? this.amount,
            amountCharged: amountCharged ?? this.amountCharged,
            authModel: authModel ?? this.authModel,
            currency: currency ?? this.currency,
            fee: fee ?? this.fee,
            vat: vat ?? this.vat,
            responseMessage: responseMessage ?? this.responseMessage,
            paymentReference: paymentReference ?? this.paymentReference,
            status: status ?? this.status,
            transactionReference: transactionReference ?? this.transactionReference,
            card: card ?? this.card,
        );

    factory ChargeCardResponseModel.fromJson(Map<String, dynamic> json) => ChargeCardResponseModel(
        amount: json["amount"],
        amountCharged: json["amount_charged"],
        authModel: json["auth_model"],
        currency: json["currency"],
        fee: json["fee"]?.toDouble(),
        vat: json["vat"]?.toDouble(),
        responseMessage: json["response_message"],
        paymentReference: json["payment_reference"],
        status: json["status"],
        transactionReference: json["transaction_reference"],
        card: json["card"] == null ? null : Card.fromJson(json["card"]),
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "amount_charged": amountCharged,
        "auth_model": authModel,
        "currency": currency,
        "fee": fee,
        "vat": vat,
        "response_message": responseMessage,
        "payment_reference": paymentReference,
        "status": status,
        "transaction_reference": transactionReference,
        "card": card?.toJson(),
    };
}

class Card {
    final String? cardType;
    final String? firstSix;
    final String? lastFour;
    final String? expiry;

    Card({
        this.cardType,
        this.firstSix,
        this.lastFour,
        this.expiry,
    });

    Card copyWith({
        String? cardType,
        String? firstSix,
        String? lastFour,
        String? expiry,
    }) => 
        Card(
            cardType: cardType ?? this.cardType,
            firstSix: firstSix ?? this.firstSix,
            lastFour: lastFour ?? this.lastFour,
            expiry: expiry ?? this.expiry,
        );

    factory Card.fromJson(Map<String, dynamic> json) => Card(
        cardType: json["card_type"],
        firstSix: json["first_six"],
        lastFour: json["last_four"],
        expiry: json["expiry"],
    );

    Map<String, dynamic> toJson() => {
        "card_type": cardType,
        "first_six": firstSix,
        "last_four": lastFour,
        "expiry": expiry,
    };
}
