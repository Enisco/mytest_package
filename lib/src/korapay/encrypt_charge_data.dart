import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:pointycastle/export.dart';

// String encryptChargeData(String encryptionKey, String paymentData) {
//   final rand = SecureRandom("AES/CTR/AUTO-SEED-PRNG");
//   final sGen = Random.secure();
//   rand.seed(
//     KeyParameter(
//       Uint8List.fromList(List.generate(16, (_) => sGen.nextInt(255))),
//     ),
//   );

//   var iv = SecureRandom("AES/CTR/AUTO-SEED-PRNG").nextBytes(16);
//   var cipher = GCMBlockCipher(AESEngine());
//   var params = AEADParameters(
//     KeyParameter(Uint8List.fromList(utf8.encode(encryptionKey))),
//     128,
//     iv,
//     Uint8List.fromList([]),
//   );
//   cipher.init(true, params);

//   var encrypted = cipher.process(Uint8List.fromList(utf8.encode(paymentData)));

//   var ivToHex =
//       iv.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
//   var encryptedToHex =
//       encrypted.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
//   var authTagToHex =
//       cipher.mac.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');

//   var encryptedToHexStr = encryptedToHex.split(authTagToHex);

//   var result = '$ivToHex:${encryptedToHexStr[0]}:$authTagToHex';
//   print("result: $result");

//   return result;
// }

String encryptChargeData(String encryptionKey, String paymentData) {
  final sGen = Random.secure();

  final seed = Uint8List.fromList(
    List.generate(
      16,
      (_) => sGen.nextInt(255),
    ),
  );
  final rand = SecureRandom("AES/CTR/AUTO-SEED-PRNG")..seed(KeyParameter(seed));

  var iv = rand.nextBytes(16);
  var cipher = GCMBlockCipher(AESEngine());
  var params = AEADParameters(
    KeyParameter(Uint8List.fromList(utf8.encode(encryptionKey))),
    128,
    iv,
    Uint8List.fromList([]),
  );
  cipher.init(true, params);

  var encrypted = cipher.process(Uint8List.fromList(utf8.encode(paymentData)));

  var ivToHex =
      iv.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
  var encryptedToHex =
      encrypted.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
  var authTagToHex =
      cipher.mac.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');

  var encryptedToHexStr = encryptedToHex.split(authTagToHex);

  var result = '$ivToHex:${encryptedToHexStr[0]}:$authTagToHex';
  return result;
}
